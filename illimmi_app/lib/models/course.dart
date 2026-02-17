import 'hyper_element.dart';
import 'id_config.dart';


class ActiveElement {
  final List<HyperElement> staticElement;
  final List<HyperElement> dynamicElement;
  ActiveElement(this.staticElement, this.dynamicElement);
}


class Course {
  final String name;
  final IdConfig config;
  
  /// Le registre global pour l'accès direct (O(1)) par ID.
  /// Très utile pour retrouver un élément et changer son `endTime` via un erase.
  final Map<int, HyperElement> globalRegistry = {};

  // Cache pour la requête "Sac à dos" : on stocke le dernier résultat et son temps de requête
  double? _lastQueryTime;
  ActiveElement? _lastResult;

  /// La "Forêt de Forêts" : Une FamilyForest pour chaque index de famille.
  final Map<int, FamilyForest> familyForests = {};

  Course(this.name, this.config) {
    // On initialise une forêt par famille définie dans la config
    for (int i = 0; i < config.familyNames.length; i++) {
      familyForests[i] = FamilyForest(
        familyName: config.familyNames[i],
        maxDuration: config.duration, // On peut passer la durée max du cours ici pour éviter des arbres trop profonds
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
    familyForests[familyIndex]!.insert(element);
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

  FamilyForest({required this.familyName, double maxDuration = 1200}) {
    // On s'assure que la racine couvre au moins toute la durée possible
    root = SegmentNode(0, maxDuration);
  }

  void insert(HyperElement element) {
    _insertRecursive(root, element);
  }

  void _insertRecursive(SegmentNode node, HyperElement element) {
    // 1. Gestion de l'infini : on capte la fin à la limite de la forêt
    double effectiveEnd = element.endTime.isInfinite ? root.end : element.endTime;

    // 1.1 Optimisation : inctroduction d'une règle de Tolérance
    // Si par exemple l'élément commence à 0.5 et que le segment commence à 0, on peut considérer que l'élément couvre le segment entier (surtout pour les éléments très courts) 
    // On peut introduire une tolérance de 0.5s pour éviter de créer des branches inutiles pour des éléments qui chevauchent légèrement les segments.
    // On accepte de le stocker ici si l'écart est <= 0.5
    double tolerance = 0.5;
    bool coversStart = element.startTime <= node.start + tolerance;
    bool coversEnd = effectiveEnd >= node.end - tolerance;
    // 2. Condition de stockage idéal : l'élément couvre avec tolerance tout le segment du nœud
    if (coversStart && coversEnd) {
      node.elements.add(element);
      print('✅ [${familyName}] ID ${element.id} stocké dans [${node.start}s - ${node.end}s]');
      return;
    }

    // 3. Si on ne couvre pas tout même avec la tolerance, on essaie de diviser
    node.ensureChildren();

    if (node.hasChildren) {
      double mid = node.left!.end; // Le point de division est la fin du segment gauche (ou le début du segment droit)

      // Un élément peut être envoyé à gauche, à droite, ou AUX DEUX 
      // s'il chevauche le point du milieu (mid).
      // On inserera dans les deux branches si l'élément chevauche le point de division (mid) pour éviter de perdre des éléments qui pourraient être actifs à la frontière.
      // Par exemple, un élément qui commence à 0.5s et que le segment gauche couvre de 0 à 1s, il devrait être inséré dans les deux branches pour garantir qu'il soit trouvé lors des requêtes à 0.5s ou 1s.
      if (element.startTime < mid) {
        _insertRecursive(node.left!, element);
      }
      if (effectiveEnd > mid) {
        _insertRecursive(node.right!, element);
      }
    } else {
      // 4. FILETS DE SÉCURITÉ : Si on ne peut plus diviser (segment < 1s)
      // on force le stockage ici pour éviter de perdre l'élément.
      if (!node.elements.contains(element)) {
        node.elements.add(element);
        print('⚠️ [${familyName}] ID ${element.id} placé par défaut dans feuille [${node.start}s - ${node.end}s]');
      }
    }
  }

  void query(double time, List<HyperElement> dynamicResults, List<HyperElement> staticResults) {
    _queryRecursive(root, time, dynamicResults, staticResults);
  }

  void _queryRecursive(SegmentNode node, double time, List<HyperElement> dynamicResults, List<HyperElement> staticResults) {
    // Si le temps demandé est hors de ce segment, on arrête de chercher ici
    if (time < node.start || time > node.end) return;

    // On récupère les éléments de ce nœud
    for (var e in node.elements) {
      // On vérifie s'il est vivant à cet instant (important pour les Erase)
      if (time >= e.startTime && time <= e.endTime) {
        // Logique d'animation (dynamic) vs affichage simple (static)
        if (time <= e.startTime + e.duration) {
          dynamicResults.add(e);
        } else {
          staticResults.add(e);
        }
      }
    }

    // On continue la recherche dans les enfants
    if (node.hasChildren) {
      _queryRecursive(node.left!, time, dynamicResults, staticResults);
      _queryRecursive(node.right!, time, dynamicResults, staticResults);
    }
  }
}

class SegmentNode {
  final double start;
  final double end;
  final List<HyperElement> elements = [];
  SegmentNode? left;
  SegmentNode? right;

  SegmentNode(this.start, this.end);

  bool get hasChildren => left != null && right != null;

  void ensureChildren() {
    // On ne divise que si on n'a pas d'enfants ET que le segment est assez large
    // Un seuil de 0.5s ou 1s est raisonnable.
    double seuil = 0.5;
    if (!hasChildren && (end - start > seuil)) {
      double mid = (start + end) / 2;

      // on force le milieu à être un entier ou entier.5
      mid = (mid * 2).round() / 2;

      // Sécurité pour éviter que le mid soit égal au start ou end à cause de l'arrondi
      if(mid <= start || mid >= end) {
        mid = start + (end - start) / 2; // On revient à la division classique si l'arrondi pose problème
      }
      left = SegmentNode(start, mid);
      right = SegmentNode(mid, end);
    }
  }
}