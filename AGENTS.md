# AGENTS.md

## DevOps Tools Installation Script

### Overview
Script d'automatisation modulaire pour l'installation et la configuration des outils DevOps sur Debian/Ubuntu et dérivés.

### Architecture

- **`install-devops-tools.sh`** : Script orchestrateur principal avec gestion des packs, dépendances, et résumé d'installation
- **`scripts/common.sh`** : Fonctions partagées (couleurs, print, command_exists, ensure_apt_updated)
- **`scripts/install-<outil>.sh`** : Script individuel par outil, source `common.sh`

### Conventions de Code

- Chaque script individuel :
  - Commence par `set -euo pipefail`
  - Source `common.sh` pour les fonctions partagées
  - Utilise `command_exists` pour vérifier si l'outil est déjà installé
  - Utilise `ensure_apt_updated` pour éviter les `apt-get update` répétés
  - Utilise un répertoire temporaire (`mktemp -d`) pour les téléchargements
  - Vérifie l'installation après chaque étape

- Script principal :
  - Gère les dépendances via le tableau `DEPENDENCIES`
  - Déduplique les outils si plusieurs packs se chevauchent
  - Continue sur erreur avec `--continue-on-error`
  - Affiche un résumé des succès/échecs

### Outils Installes (30 outils)

#### Conteneurisation & Orchestration
- docker, kubectl (v1.32), helm

#### Cloud & IaC
- terraform, ansible (venv), aws-cli v2, azure-cli, gcloud

#### Securite
- vault, trivy, checkov (venv)

#### Testing
- k6, newman (npm)

#### Langages
- nodejs (NodeSource LTS), rust (rustup), php 8.3 (sury/PPA), python3 + uv, go (derniere version), nvm

#### Gestionnaires
- composer (necessite php), yarn (npm)

#### Utilitaires
- git, gh, jq, yq, htop, tmux, starship, oh-my-zsh, nerd-fonts

### Dependances entre Outils
- `composer` -> `php`
- `newman` -> `nodejs`
- `yarn` -> `nodejs`

### Packs Disponibles
- `tools`: git docker gh kubectl terraform aws-cli ansible helm jq yq
- `security`: vault trivy checkov
- `testing`: k6 newman
- `languages`: nodejs rust php python composer yarn nvm go
- `essential`: git docker kubectl terraform ansible
- `utils`: jq yq htop tmux starship
- `shell`: oh-my-zsh
- `fonts`: nerd-fonts
- `cloud`: aws-cli azure-cli gcloud
- `full`: tous les outils

### Systemes Supportes
Debian/Ubuntu et derives (Linux Mint, Pop!_OS) uniquement.

### Tests
Pour valider : `./install-devops-tools.sh --dry-run full`

### Lint
```bash
shellcheck install-devops-tools.sh scripts/*.sh
```