// services/speech_manager.dart
/*import 'package:flutter_tts/flutter_tts.dart';

class SpeechManager {
  static final SpeechManager _instance = SpeechManager._internal();
  factory SpeechManager() => _instance;
  SpeechManager._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;
  bool _isSpeaking = false;
  String? _currentSpeechId;
  
  // Paramètres configurables
  double _volume = 1.0;
  double _rate = 0.5; // Vitesse (0.0 à 1.0)
  double _pitch = 1.0; // Hauteur de voix
  String _language = 'fr-FR';
  
  // Callbacks
  Function()? onStart;
  Function()? onComplete;
  Function(String)? onProgress;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    print('🎤 Initialisation du moteur de synthèse vocale...');
    
    try {
      // Configuration de base
      await _flutterTts.setLanguage(_language);
      await _flutterTts.setVolume(_volume);
      await _flutterTts.setSpeechRate(_rate);
      await _flutterTts.setPitch(_pitch);
      
      // Configuration spécifique à la plateforme
      await _configurePlatformSettings();
      
      // Callbacks
      _flutterTts.setStartHandler(() {
        print('🎙️ Speech started');
        _isSpeaking = true;
        onStart?.call();
      });
      
      _flutterTts.setCompletionHandler(() {
        print('✅ Speech completed');
        _isSpeaking = false;
        _currentSpeechId = null;
        onComplete?.call();
      });
      
      _flutterTts.setProgressHandler((text, start, end, word) {
        print('📝 Progress: $word');
        onProgress?.call(word);
      });
      
      _flutterTts.setErrorHandler((msg) {
        print('❌ Speech error: $msg');
        _isSpeaking = false;
        _currentSpeechId = null;
      });
      
      _isInitialized = true;
      print('✅ Moteur de synthèse vocale initialisé');
      
      // Lister les voix disponibles
      await _listAvailableVoices();
      
    } catch (e) {
      print('❌ Erreur initialisation TTS: $e');
      rethrow;
    }
  }

  Future<void> _configurePlatformSettings() async {
    // Configuration Windows et autres plateformes
    if (await _flutterTts.isLanguageAvailable(_language)) {
      print('✅ Langue $_language disponible');
    } else {
      print('⚠️ Langue $_language non disponible, utilisation de la langue par défaut');
    }
    
    // Configuration Android - attendre la fin de la synthèse
    try {
      await _flutterTts.awaitSpeakCompletion(true);
    } catch (e) {
      // Ignoré si la plateforme ne supporte pas cette méthode
      print('⚠️ awaitSpeakCompletion non supporté: $e');
    }
  }

  Future<void> _listAvailableVoices() async {
    try {
      final voices = await _flutterTts.getVoices;
      if (voices != null && voices is List) {
        print('🔊 Voix disponibles:');
        int frenchCount = 0;
        for (var voice in voices) {
          if (voice is Map) {
            final name = voice['name'];
            final locale = voice['locale'];
            if (locale != null && locale.toString().startsWith('fr')) {
              print('  ✅ $name ($locale)');
              frenchCount++;
            }
          }
        }
        print('📊 Total voix françaises: $frenchCount');
      }
    } catch (e) {
      print('⚠️ Impossible de lister les voix: $e');
    }
  }

  Future<void> speak(String text, {String? speechId}) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    // Si un speech est déjà en cours, l'arrêter
    if (_isSpeaking) {
      await stop();
    }
    
    _currentSpeechId = speechId;
    
    print('🎙️ Synthèse vocale: "${text.substring(0, text.length > 50 ? 50 : text.length)}..."');
    
    try {
      await _flutterTts.speak(text);
    } catch (e) {
      print('❌ Erreur synthèse vocale: $e');
      _isSpeaking = false;
      _currentSpeechId = null;
    }
  }

  Future<void> stop() async {
    if (_isSpeaking) {
      print('⏹️ Arrêt de la synthèse vocale');
      await _flutterTts.stop();
      _isSpeaking = false;
      _currentSpeechId = null;
    }
  }

  Future<void> pause() async {
    if (_isSpeaking) {
      print('⏸️ Pause de la synthèse vocale');
      await _flutterTts.pause();
    }
  }

  // Setters pour les paramètres
  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0);
    await _flutterTts.setVolume(_volume);
    print('🔊 Volume: ${(_volume * 100).toInt()}%');
  }

  Future<void> setRate(double rate) async {
    _rate = rate.clamp(0.0, 1.0);
    await _flutterTts.setSpeechRate(_rate);
    print('⚡ Vitesse: ${(_rate * 100).toInt()}%');
  }

  Future<void> setPitch(double pitch) async {
    _pitch = pitch.clamp(0.5, 2.0);
    await _flutterTts.setPitch(_pitch);
    print('🎵 Hauteur: $pitch');
  }

  Future<void> setLanguage(String language) async {
    _language = language;
    await _flutterTts.setLanguage(_language);
    print('🌍 Langue: $_language');
  }

  Future<void> setVoice(Map<String, String> voice) async {
    try {
      await _flutterTts.setVoice(voice);
      print('🗣️ Voix: ${voice['name']}');
    } catch (e) {
      print('❌ Erreur changement de voix: $e');
    }
  }

  // Getters
  bool get isSpeaking => _isSpeaking;
  String? get currentSpeechId => _currentSpeechId;
  double get volume => _volume;
  double get rate => _rate;
  double get pitch => _pitch;
  String get language => _language;

  Future<List<Map<String, String>>> getAvailableVoices() async {
    try {
      final voices = await _flutterTts.getVoices;
      if (voices != null && voices is List) {
        return voices
            .where((v) => v is Map)
            .map((v) => Map<String, String>.from(v as Map))
            .where((v) => v['locale']?.startsWith('fr') ?? false)
            .toList();
      }
    } catch (e) {
      print('❌ Erreur récupération des voix: $e');
    }
    return [];
  }

  void dispose() {
    _flutterTts.stop();
  }
}*/