# ==============================================================================
# Script d'Automation Tout-en-Un pour ILLIMMI
# Lancement automatique des services natifs + stack Docker Compose avec credits GCP
# ==============================================================================

Write-Host "[*] Initialisation de la stack ILLIMMI..." -ForegroundColor Cyan

# 1. Configuration des variables d'environnement
if (-not $env:AUTH_JWT_SECRET) {
    $env:AUTH_JWT_SECRET = "change_moi_en_production"
}

# Detection et rafraichissement automatique du token GCP
if (Get-Command gcloud -ErrorAction SilentlyContinue) {
    if (-not $env:GCP_PROJECT_ID) {
        $gcpProj = (gcloud config get-value project 2>$null)
        if ($gcpProj) {
            $env:GCP_PROJECT_ID = $gcpProj.Trim()
        }
    }
    if ($env:GCP_PROJECT_ID -and -not $env:GCP_ACCESS_TOKEN) {
        Write-Host "[KEY] Recuperation automatique du jeton d'acces GCP ($env:GCP_PROJECT_ID)..." -ForegroundColor Yellow
        $token = (gcloud auth print-access-token 2>$null)
        if ($token) {
            $env:GCP_ACCESS_TOKEN = $token.Trim()
        }
    }
}

if ($env:GCP_PROJECT_ID -and $env:GCP_ACCESS_TOKEN) {
    Write-Host "[OK] Mode Credits GCP / BigQuery actif (Projet: $env:GCP_PROJECT_ID)" -ForegroundColor Green
} elseif ($env:GEMINI_API_KEY) {
    Write-Host "[OK] Mode Cle API Gemini directe actif" -ForegroundColor Green
} else {
    Write-Host "[!] Information: Aucune cle API configuree." -ForegroundColor Yellow
    Write-Host "    L'application Flutter peut fonctionner en mode demo autonome (exemples inclus)." -ForegroundColor Yellow
}

# 2. Verification des dependances pub get pour les services natifs
$audioDir = Join-Path $PSScriptRoot "services\audio_service"
$userDir  = Join-Path $PSScriptRoot "services\user_service"

if (Test-Path $audioDir) {
    if (-not (Test-Path "$audioDir\.dart_tool")) {
        Write-Host "[PUB] Installation des dependances audio-service..." -ForegroundColor Cyan
        Push-Location $audioDir; dart pub get; Pop-Location
    }
}

if (Test-Path $userDir) {
    if (-not (Test-Path "$userDir\.dart_tool")) {
        Write-Host "[PUB] Installation des dependances user-service..." -ForegroundColor Cyan
        Push-Location $userDir; dart pub get; Pop-Location
    }
}

# 3. Demarrage en arriere-plan des services natifs Windows (audio-service & user-service)
$audioProcess = $null
$userProcess = $null

if (Test-Path $audioDir) {
    Write-Host "[AUDIO] Demarrage de audio-service sur http://localhost:8082..." -ForegroundColor Cyan
    $audioProcess = Start-Process -FilePath "dart" -ArgumentList "run bin/server.dart" -WorkingDirectory $audioDir -PassThru -WindowStyle Hidden
}

if (Test-Path $userDir) {
    Write-Host "[USER] Demarrage de user-service sur http://localhost:8081..." -ForegroundColor Cyan
    $userProcess  = Start-Process -FilePath "dart" -ArgumentList "run bin/server.dart" -WorkingDirectory $userDir -PassThru -WindowStyle Hidden
}

Write-Host "[...] Attente de 3 secondes le temps que les services s'initialisent..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

# 4. Lancement de l'application Flutter en mode UI si demande ou informations
Write-Host "[UI] Pour lancer l'application Flutter UI Gemini :" -ForegroundColor Green
Write-Host "     cd illimmi_app ; flutter run -d windows (ou -d chrome)" -ForegroundColor Green

# Nettoyage a l'arret du script si interrompu
try {
    if (Get-Command docker -ErrorAction SilentlyContinue) {
        Write-Host "[DOCKER] Lancement des conteneurs Docker (orchestrator, plot, board-render)..." -ForegroundColor Cyan
        docker compose up --build
    } else {
        Write-Host "[INFO] Docker n'est pas installe. Les services natifs tournent en arriere-plan." -ForegroundColor Yellow
        Write-Host "       Appuyez sur Entree pour arreter les services..." -ForegroundColor Yellow
        Read-Host
    }
} finally {
    Write-Host "[STOP] Arret des services natifs..." -ForegroundColor Red
    if ($audioProcess -and -not $audioProcess.HasExited) { Stop-Process -Id $audioProcess.Id -Force }
    if ($userProcess  -and -not $userProcess.HasExited)  { Stop-Process -Id $userProcess.Id -Force }
}
