# Nécessite un moteur Flutter (pas seulement le SDK Dart) : `bin/serve.dart`
# route les requêtes vers `flutter test` dans illimmi_app, qui réutilise le
# vrai code de rendu de production. Build depuis la racine du repo (pas
# `./services/board-render-service` comme plot-service) puisque ce
# Dockerfile a besoin à la fois d'illimmi_app/ et de ce service — voir
# docker-compose.yml.
FROM ghcr.io/cirruslabs/flutter:stable

WORKDIR /workspace

COPY illimmi_app ./illimmi_app
RUN cd illimmi_app && flutter pub get

COPY services/board_render_service ./services/board_render_service
RUN cd services/board_render_service && dart pub get

ENV ILLIMMI_APP_DIR=/workspace/illimmi_app
EXPOSE 5001

WORKDIR /workspace/services/board_render_service
CMD ["dart", "run", "bin/serve.dart"]
