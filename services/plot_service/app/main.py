"""Microservice ILLIMMI plot-service.

Implémente le contrat déjà attendu par le client Flutter
(`lib/board_plotter/plot_widget.dart`, jamais servi jusqu'ici) :

    POST /plot_interactive  {"code": "<snippet Python laissant une variable `fig`>"}
    -> 200, Content-Type: text/html, corps = HTML brut affiché tel quel dans une WebView.

Le client ne distingue que succès (200) / échec (non-200) — pas de contrat
JSON sur la réponse elle-même.
"""

import builtins
import io
import matplotlib

matplotlib.use("Agg")  # pas d'affichage interactif côté serveur

import matplotlib.pyplot as plt
import numpy as np
import plotly.graph_objects as go
from concurrent.futures import ThreadPoolExecutor, TimeoutError as FutureTimeoutError
from fastapi import FastAPI
from fastapi.responses import HTMLResponse, JSONResponse
from pydantic import BaseModel

app = FastAPI(title="ILLIMMI plot-service")

EXECUTION_TIMEOUT_SECONDS = 10

# Namespace restreint : seuls les builtins nécessaires à un snippet de plot
# (pas de open/exec/eval/__import__/input) — le code exécuté vient d'un
# `.hc` écrit à la main aujourd'hui, mais rien ne garantit qu'il en sera
# toujours ainsi, donc on limite la surface par défaut.
_SAFE_BUILTIN_NAMES = (
    "abs", "all", "any", "bool", "dict", "enumerate", "float", "int", "len",
    "list", "map", "max", "min", "print", "range", "round", "set", "sorted",
    "str", "sum", "tuple", "zip", "True", "False", "None",
)
_SAFE_BUILTINS = {name: getattr(builtins, name) for name in _SAFE_BUILTIN_NAMES}

_executor = ThreadPoolExecutor(max_workers=4)


class PlotRequest(BaseModel):
    code: str


def _run_snippet(code: str) -> str:
    namespace = {
        "__builtins__": _SAFE_BUILTINS,
        "plt": plt,
        "np": np,
        "go": go,
    }
    exec(code, namespace)

    fig = namespace.get("fig")
    if fig is None:
        raise ValueError("Le snippet doit laisser une variable nommée `fig`.")

    if isinstance(fig, go.Figure):
        return fig.to_html(full_html=True, include_plotlyjs="cdn")

    # Sinon on suppose une Figure matplotlib.
    import mpld3

    html = mpld3.fig_to_html(fig)
    plt.close(fig)
    return f"<!doctype html><html><body style='background:transparent'>{html}</body></html>"


@app.post("/plot_interactive")
def plot_interactive(request: PlotRequest):
    future = _executor.submit(_run_snippet, request.code)
    try:
        html = future.result(timeout=EXECUTION_TIMEOUT_SECONDS)
    except FutureTimeoutError:
        return JSONResponse(
            status_code=500,
            content={"error": f"Timeout après {EXECUTION_TIMEOUT_SECONDS}s d'exécution."},
        )
    except Exception as e:  # noqa: BLE001 - on renvoie toute erreur du snippet au client
        return JSONResponse(status_code=500, content={"error": str(e)})

    return HTMLResponse(content=html, status_code=200)


@app.get("/health")
def health():
    return {"status": "ok"}
