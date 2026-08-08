import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../../models/basic_elements/plot_element.dart';

/// URL du microservice `plot-service` (voir `services/plot-service/`).
/// Configurable via la variable d'environnement `PLOT_SERVICE_URL` pour
/// pointer vers une instance containerisée ; défaut inchangé (local, port
/// 5000) pour ne rien casser en dev sans config supplémentaire.
final String plotServiceUrl =
    Platform.environment['PLOT_SERVICE_URL'] ?? 'http://127.0.0.1:5000';

class PlotWidget extends StatefulWidget {
  final PlotElement element;
  const PlotWidget({super.key, required this.element});
  @override
  State<PlotWidget> createState() => _PlotWidgetState();
}

class _PlotWidgetState extends State<PlotWidget> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _generateAndLoadPlot();
  }

  void _generateAndLoadPlot() async {
    try {
      final response = await http.post(
        Uri.parse('$plotServiceUrl/plot_interactive'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'code': widget.element.code}),
      );
      if (response.statusCode == 200) {
        _controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..loadHtmlString(response.body);
        if(mounted) setState(() => _isLoading = false);
      } else {
        if(mounted) setState(() => _errorMessage = "Erreur du serveur: ${response.statusCode}");
      }
    } catch (e) {
      if(mounted) setState(() => _errorMessage = "Connexion impossible au serveur Python.");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) return Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)));
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    return WebViewWidget(controller: _controller);
  }
}