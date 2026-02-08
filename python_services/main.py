"""
Serveur Flask pour générer des graphiques interactifs Plotly
À lancer avec: python plot_server.py
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
import plotly.graph_objects as go
import plotly.express as px
import numpy as np
import io
import sys
from contextlib import redirect_stdout, redirect_stderr

app = Flask(__name__)
CORS(app)  # Permet les requêtes depuis Flutter


@app.route('/plot_interactive', methods=['POST'])
def plot_interactive():
    """
    Endpoint qui reçoit du code Python et retourne du HTML Plotly interactif
    """
    try:
        data = request.get_json()
        code = data.get('code', '')

        if not code:
            return jsonify({'error': 'No code provided'}), 400

        # Créer un namespace sécurisé pour l'exécution
        namespace = {
            'np': np,
            'go': go,
            'px': px,
            'fig': None,  # La figure sera stockée ici
        }

        # Capturer stdout/stderr
        stdout_capture = io.StringIO()
        stderr_capture = io.StringIO()

        # Exécuter le code utilisateur
        with redirect_stdout(stdout_capture), redirect_stderr(stderr_capture):
            try:
                exec(code, namespace)
            except Exception as e:
                return jsonify({
                    'error': f'Execution error: {str(e)}',
                    'stderr': stderr_capture.getvalue()
                }), 400

        # Récupérer la figure
        fig = namespace.get('fig')

        if fig is None:
            return jsonify({'error': 'No figure created. Make sure to assign your plot to "fig"'}), 400

        # Configurer la figure pour l'intégration
        fig.update_layout(
            autosize=True,
            margin=dict(l=20, r=20, t=40, b=20),
            paper_bgcolor='rgba(0,0,0,0)',
            plot_bgcolor='rgba(0,0,0,0)',
        )

        # Convertir en HTML interactif
        html = fig.to_html(
            include_plotlyjs='cdn',  # Utilise le CDN Plotly
            config={
                'responsive': True,
                'displayModeBar': True,
                'displaylogo': False,
            }
        )

        return html, 200, {'Content-Type': 'text/html'}

    except Exception as e:
        return jsonify({'error': f'Server error: {str(e)}'}), 500


@app.route('/health', methods=['GET'])
def health():
    """Endpoint pour vérifier que le serveur fonctionne"""
    return jsonify({'status': 'ok'}), 200


if __name__ == '__main__':
    print("🚀 Serveur de graphiques Python démarré sur http://127.0.0.1:5000")
    print("📊 Endpoints disponibles:")
    print("  - POST /plot_interactive : Générer un graphique")
    print("  - GET /health : Vérifier le statut")
    app.run(host='127.0.0.1', port=5000, debug=True)