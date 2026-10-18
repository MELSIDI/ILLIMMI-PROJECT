@echo off
chcp 65001 > nul
echo ============================================================
echo   ILLIMMI - LANCEMENT DU LOT QUOTIDIEN DU CORPUS (1000 COURS)
echo ============================================================
echo.

set BATCH_SIZE=25
if not "%1"=="" set BATCH_SIZE=%1

echo Configuration : Lot de %BATCH_SIZE% cours avec respect des quotas YouTube.
echo Moteurs actifs : Piper TTS + Whisper.cpp + Antigravity Engine + World Model.
echo.

python corpus_illimmi_1000\tools\agentic_corpus_runner.py --batch-size %BATCH_SIZE%

echo.
echo ============================================================
echo   Lot quotidien terminé. À demain pour la suite du corpus !
echo ============================================================
pause
