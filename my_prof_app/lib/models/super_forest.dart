import 'hyper_element.dart';
import 'id_config.dart';


class ActiveElement {
  final List<HyperElement> staticElement;
  final List<HyperElement> dynamicElement;
  ActiveElement(this.staticElement, this.dynamicElement);
}


class SuperForest {
  final IdConfig config;
  
  /// Le registre global pour l'accès direct (O(1)) par ID.
  /// Très utile pour retrouver un élément et changer son `endTime` via un erase.
  final Map<int, HyperElement> globalRegistry = {};

  // Cache pour la requête "Sac à dos" : on stocke le dernier résultat et son temps de requête
  double? _lastQueryTime;
  ActiveElement? _lastResult;

  /// La "Forêt de Forêts" : Une FamilyForest pour chaque index de famille.
  final Map<int, FamilyForest> familyForests = {};

  SuperForest(this.config) {
    // On initialise une forêt par famille définie dans la config
    for (int i = 0; i < config.familyNames.length; i++) {
      familyForests[i] = FamilyForest(
        familyName: config.familyNames[i],
        // On pourrait passer des précisions temporelles différentes ici
      );
    }
  }

  /// Insère un élément dans la structure
  void insert(HyperElement element) {
    // 1. Validation de l'ID via ta classe IdConfig
    final int familyIndex = config.getFamilyIndex(element.id);

    // 2. Vérification des doublons
    if (globalRegistry.containsKey(element.id)) {
      throw Exception("ID Collision: L'ID ${element.id} est déjà utilisé.");
    }

    // 3. Enregistrement dans le registre global (référence)
    globalRegistry[element.id] = element;

    // 4. Insertion dans la forêt spécifique à sa famille
    familyForests[familyIndex]?.insert(element);
  }

  /// Gère l'effacement d'un élément (Erase)
  void handleErase(int targetId, double eraseTime) {
    final element = globalRegistry[targetId];
    if (element != null) {
      // On ferme la fenêtre de vie. 
      // Comme l'élément est passé par référence dans les arbres de segments,
      // la modification est répercutée partout instantanément.
      element.endTime = eraseTime;
    } else {
      throw Exception("Warning: Tentative d'effacer un ID inexistant ($targetId)");
    }
  }

  /// La requête "Sac à dos" : Récupère tout ce qui est vivant à l'instant T
  ActiveElement queryAll(double time) {
    if (_lastQueryTime != null && _lastQueryTime == time) return _lastResult!; // On ne recalcule pas si le temps n'a pas bougé
    List<HyperElement> staticElements = [];
    List<HyperElement> dynamicElements = [];
    
    // On interroge chaque forêt de famille
    for (var forest in familyForests.values) {
      forest.query(time, dynamicElements, staticElements);
    }
    
    _lastQueryTime = time;
    _lastResult = ActiveElement(staticElements, dynamicElements);
    return _lastResult!;
  }
}


class FamilyForest {
  final String familyName;
  late final SegmentNode root;

  // On part sur une durée max par défaut de 1h (3600s), ajustable.
  FamilyForest({required this.familyName, double maxDuration = 3600}) {
    root = SegmentNode(0, maxDuration);
  }

  void insert(HyperElement element) {
    _insertRecursive(root, element);
  }

  void _insertRecursive(SegmentNode node, HyperElement element) {
    // Si l'élément couvre tout le segment du nœud, on le stocke ici
    if (element.startTime <= node.start && element.endTime >= node.end) {
      node.elements.add(element);
      return;
    }

    // Sinon, on divise et on descend
    node.ensureChildren();
    double mid = (node.start + node.end) / 2;

    if (element.startTime < mid) _insertRecursive(node.left!, element);
    if (element.endTime >= mid) _insertRecursive(node.right!, element);
  }

  void query(double time, List<HyperElement> dynamicResults, List<HyperElement> staticResults) {
    _queryRecursive(root, time, dynamicResults, staticResults);
  }

  void _queryRecursive(SegmentNode node, double time, List<HyperElement> dynamicResults, List<HyperElement> staticResults) {
    if (time < node.start || time > node.end) return;

    // On ajoute les éléments de ce nœud (ceux qui durent sur tout le segment)
    // IMPORTANT: On vérifie quand même le endTime car il a pu être modifié par un erase !
    for (var e in node.elements) {
      if (e.startTime <= time && time <= e.endTime) {
        if (time <= e.startTime + e.duration) {
          dynamicResults.add(e);
        } else {
          staticResults.add(e);
        }
      }
    }

    if (node.hasChildren) {
      _queryRecursive(node.left!, time, dynamicResults, staticResults);
      _queryRecursive(node.right!, time, dynamicResults, staticResults);
    }
  }
}


class SegmentNode {
  final double start;
  final double end;
  List<HyperElement> elements = [];
  SegmentNode? left;
  SegmentNode? right;

  SegmentNode(this.start, this.end);

  bool get hasChildren => left != null && right != null;

  void ensureChildren() {
    if (!hasChildren && (end - start > 0.5)) { // On évite de diviser à l'infini pour des segments très petits
      double mid = (start + end) / 2;
      left = SegmentNode(start, mid);
      right = SegmentNode(mid, end);
    }
  }
}