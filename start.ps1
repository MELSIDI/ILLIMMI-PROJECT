# ==============================================================================
# Script d'Automation Tout-en-Un pour ILLIMMI
# Lancement automatique des services natifs (avec fallback si Docker absent/inactif)
# ==============================================================================

Write-Host "[*] Initialisation de la stack ILLIMMI..." -ForegroundColor Cyan

# 0. Arret de tout ancien processus Dart s'il y en a un qui tourne
Get-Process -Name "dart" -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -eq "" } | Stop-Process -Force -ErrorAction SilentlyContinue

# 1. Chargement des variables d'environnement depuis le fichier .env
$envFile = Join-Path $PSScriptRoot ".env"
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith("#") -and $line.Contains("=")) {
            $parts = $line.Split("=", 2)
            $varName = $parts[0].Trim()
            $varValue = $parts[1].Trim().Trim('"').Trim("'")
            Set-Item "env:$varName" $varValue
        }
    }
}

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
    Write-Host "[OK] Mode Cle API Gemini directe actif (Modele: $env:GEMINI_MODEL)" -ForegroundColor Green
} else {
    Write-Host "[!] Information: Aucune cle API configuree." -ForegroundColor Yellow
    Write-Host "    L'application Flutter peut fonctionner en mode demo autonome (exemples inclus)." -ForegroundColor Yellow
}

# 2. Verification des dependances pub get pour les services natifs
$audioDir        = Join-Path $PSScriptRoot "services\audio_service"
$userDir         = Join-Path $PSScriptRoot "services\user_service"
$renderDir       = Join-Path $PSScriptRoot "services\board_render_service"
$orchestratorDir = Join-Path $PSScriptRoot "services\generation_orchestrator"

foreach ($dir in @($audioDir, $userDir, $renderDir, $orchestratorDir)) {
    if (Test-Path $dir) {
        if (-not (Test-Path "$dir\.dart_tool")) {
            $name = Split-Path $dir -Leaf
            Write-Host "[PUB] Installation des dependances pour $name..." -ForegroundColor Cyan
            Push-Location $dir; dart pub get; Pop-Location
        }
    }
}

# 3. Demarrage des services natifs
$audioProcess  = $null
$userProcess   = $null
$renderProcess = $null
$orchProcess   = $null

if (Test-Path $audioDir) {
    Write-Host "[AUDIO] Demarrage de audio-service sur http://localhost:8082..." -ForegroundColor Cyan
    $audioProcess = Start-Process -FilePath "dart" -ArgumentList "run bin/server.dart" -WorkingDirectory $audioDir -PassThru -WindowStyle Hidden
}

if (Test-Path $userDir) {
    Write-Host "[USER] Demarrage de user-service sur http://localhost:8081..." -ForegroundColor Cyan
    $userProcess  = Start-Process -FilePath "dart" -ArgumentList "run bin/server.dart" -WorkingDirectory $userDir -PassThru -WindowStyle Hidden
}

if (Test-Path $renderDir) {
    Write-Host "[RENDER] Demarrage de board-render-service sur http://localhost:5001..." -ForegroundColor Cyan
    $renderProcess = Start-Process -FilePath "dart" -ArgumentList "run bin/serve.dart" -WorkingDirectory $renderDir -PassThru -WindowStyle Hidden
}

# Verification si le daemon Docker est disponible et actif
$dockerAvailable = $false
if (Get-Command docker -ErrorAction SilentlyContinue) {
    docker info 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) {
        $dockerAvailable = $true
    }
}

try {
    if ($dockerAvailable) {
        Write-Host "[DOCKER] Daemon Docker actif - Lancement du cluster Docker Compose..." -ForegroundColor Cyan
        docker compose up --build
    } else {
        Write-Host "[INFO] Docker Desktop n'est pas lance. Lancement des services en mode natif..." -ForegroundColor Yellow
        if (Test-Path $orchestratorDir) {
            Write-Host "[ORCH] Demarrage de generation-orchestrator sur http://localhost:8080..." -ForegroundColor Cyan
            $orchProcess = Start-Process -FilePath "dart" -ArgumentList "run bin/server.dart" -WorkingDirectory $orchestratorDir -PassThru -WindowStyle Hidden
        }

        Write-Host "[...] Attente de 3 secondes le temps que les services s'initialisent..." -ForegroundColor Yellow
        Start-Sleep -Seconds 3

        Write-Host "[OK] Tous les services ILLIMMI tournent en mode natif :" -ForegroundColor Green
        Write-Host "     - generation-orchestrator : http://localhost:8080 ($env:GEMINI_MODEL)" -ForegroundColor Green
        Write-Host "     - user-service            : http://localhost:8081" -ForegroundColor Green
        Write-Host "     - audio-service           : http://localhost:8082" -ForegroundColor Green
        Write-Host "     - board-render-service    : http://localhost:5001" -ForegroundColor Green
        Write-Host ""
        Write-Host "[UI] Pour lancer l'application Flutter UI :" -ForegroundColor Green
        Write-Host "     cd illimmi_app ; flutter run -d windows" -ForegroundColor Green
        Write-Host ""
        Write-Host "Appuyez sur Entree (ou Ctrl+C) pour arreter les services natifs..." -ForegroundColor Yellow
        Read-Host
    }
} finally {
    Write-Host "[STOP] Arret des services natifs..." -ForegroundColor Red
    if ($audioProcess  -and -not $audioProcess.HasExited)  { Stop-Process -Id $audioProcess.Id -Force }
    if ($userProcess   -and -not $userProcess.HasExited)   { Stop-Process -Id $userProcess.Id -Force }
    if ($renderProcess -and -not $renderProcess.HasExited) { Stop-Process -Id $renderProcess.Id -Force }
    if ($orchProcess   -and -not $orchProcess.HasExited)   { Stop-Process -Id $orchProcess.Id -Force }
}
