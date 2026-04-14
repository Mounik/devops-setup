# DevOps Tools Installation Script

**Script d'installation automatisée des outils DevOps essentiels**

## Description

Ce projet contient un script Bash modulaire pour installer et configurer automatiquement tous les outils DevOps nécessaires sur votre poste de travail Debian/Ubuntu et dérivés.

## Fonctionnalités

- **Architecture modulaire** : Chaque outil a son propre script d'installation
- **Installation sélective** : Choisissez les outils ou packs a installer
- **Gestion des dépendances** : Les dépendances entre outils sont résolues automatiquement
- **Mode simulation** : Testez sans rien installer (`--dry-run`)
- **Mode verbeux** : Sortie détaillée pour le debugging (`--verbose`)
- **Continue sur erreur** : Ne pas bloquer si un outil échoue (`--continue-on-error`)
- **Logs détaillés** : Suivez l'installation dans `/tmp/devops-tools-install.log`
- **Résumé d'installation** : Affichage des succès/échecs en fin de script
- **Gestion d'erreur robuste** : `set -euo pipefail` dans chaque script

## Systèmes Supportés

- **Debian** (10+, 11, 12)
- **Ubuntu** (20.04+, 22.04, 24.04)
- **Dérivés** : Linux Mint, Pop!_OS

> **Note** : Seuls Debian/Ubuntu et dérivés sont officiellement supportés. Les scripts utilisent `apt-get` et les dépôts officiels de chaque éditeur.

## Outils Supportés

### Conteneurisation & Orchestration
- **Docker** (+ Docker Compose plugin, Buildx) - Conteneurisation
- **Kubernetes (kubectl)** - Orchestration de conteneurs
- **Helm** - Package manager Kubernetes

### Cloud & Infrastructure as Code
- **Terraform** - Infrastructure as Code (HashiCorp)
- **Ansible** - Automatisation et configuration (via venv Python)
- **AWS CLI** - Interface Amazon Web Services v2
- **Azure CLI** - Interface Microsoft Azure
- **gcloud** - Interface Google Cloud Platform

### Sécurité & Scanning
- **Vault** - Gestion de secrets (HashiCorp)
- **Trivy** - Scanner de vulnérabilités conteneurs (Aqua Security)
- **Checkov** - Scanner de sécurité infrastructure (via venv Python)

### Testing & Performance
- **k6** - Performance testing (Grafana)
- **Newman** - Collection runner Postman (via npm)

### Langages de Développement
- **Node.js** - Runtime JavaScript (NodeSource LTS)
- **Rust** - Langage système (rustup)
- **PHP 8.3** - Langage web avec extensions (Sury/PPA)
- **Python 3** - Langage avec pip + uv (Astral)
- **Go** - Langage compilé (dernière version stable)
- **NVM** - Node Version Manager

### Gestionnaires de Paquets
- **Composer** - Gestionnaire PHP
- **Yarn** - Gestionnaire JavaScript (via npm)

### Utilitaires & Terminal
- **jq** - Processeur JSON en ligne de commande
- **yq** - Processeur YAML en ligne de commande
- **htop** - Moniteur de processus interactif
- **tmux** - Multiplexeur de terminal
- **Starship** - Prompt shell personnalisable
- **Oh My Zsh** - Framework de configuration Zsh
- **Cascadia Code Nerd Font** - Police avec icônes pour terminaux

### Version Control
- **Git** - Contrôle de version distribué
- **GitHub CLI (gh)** - Interface en ligne de commande GitHub

## Installation Rapide

```bash
# Clonez le repository
git clone https://gitlab.com/Mounik/setup-devops.git
cd setup-devops

# Rendez le script exécutable
chmod +x install-devops-tools.sh

# Installation complète de tous les outils
./install-devops-tools.sh

# Installation par pack
./install-devops-tools.sh tools        # Outils DevOps essentiels
./install-devops-tools.sh security     # Outils de sécurité et scanning
./install-devops-tools.sh testing      # Outils de testing et performance
./install-devops-tools.sh languages    # Langages de développement
./install-devops-tools.sh essential    # Git, Docker, kubectl, Terraform, Ansible
./install-devops-tools.sh utils        # jq, yq, htop, tmux, starship
./install-devops-tools.sh shell        # Oh My Zsh
./install-devops-tools.sh fonts        # Cascadia Code Nerd Font
./install-devops-tools.sh cloud        # AWS CLI, Azure CLI, gcloud

# Installation d'outils spécifiques
./install-devops-tools.sh git docker kubectl terraform ansible
```

## Options

```bash
Options:
  -h, --help              Affiche l'aide
  -d, --dry-run           Simulation sans installation
  -v, --verbose           Mode verbeux
  -l, --list              Lister les packs et outils disponibles
  -c, --continue-on-error Continuer l'installation même si un outil échoue
```

## Exemples d'Utilisation

```bash
# Installation complète
./install-devops-tools.sh

# Installation par packs
./install-devops-tools.sh tools security

# Installation sélective
./install-devops-tools.sh git docker kubectl terraform

# Simulation
./install-devops-tools.sh --dry-run full

# Mode verbeux
./install-devops-tools.sh -v essential

# Continuer même en cas d'erreur
./install-devops-tools.sh --continue-on-error full

# Lister les packs et outils disponibles
./install-devops-tools.sh --list
```

## Dépendances Automatiques

Le script résout automatiquement les dépendances entre outils :

| Outil | Dépend de |
|-------|-----------|
| composer | php |
| newman | nodejs |
| yarn | nodejs |

Si un outil a une dépendance non installée, le script l'installera automatiquement avant.

## Structure du Projet

```
setup-devops/
├── install-devops-tools.sh     # Script principal d'orchestration
├── scripts/
│   ├── common.sh               # Fonctions partagées (couleurs, utilitaires)
│   ├── install-git.sh
│   ├── install-docker.sh
│   ├── install-gh.sh
│   ├── install-kubectl.sh
│   ├── install-terraform.sh
│   ├── install-aws-cli.sh
│   ├── install-azure-cli.sh
│   ├── install-gcloud.sh
│   ├── install-ansible.sh
│   ├── install-helm.sh
│   ├── install-vault.sh
│   ├── install-trivy.sh
│   ├── install-checkov.sh
│   ├── install-k6.sh
│   ├── install-newman.sh
│   ├── install-nodejs.sh
│   ├── install-rust.sh
│   ├── install-php.sh
│   ├── install-python.sh
│   ├── install-composer.sh
│   ├── install-yarn.sh
│   ├── install-nvm.sh
│   ├── install-go.sh
│   ├── install-jq.sh
│   ├── install-yq.sh
│   ├── install-htop.sh
│   ├── install-tmux.sh
│   ├── install-starship.sh
│   ├── install-oh-my-zsh.sh
│   └── install-nerd-fonts.sh
├── docs/
│   ├── FONTS.md
│   ├── devops-tools-list.md
│   └── install-devops-tools.md
├── AGENTS.md
├── LICENSE
└── README.md
```

## Prérequis

- **Système** : Debian/Ubuntu et dérivés
- **Accès sudo** : Pour les installations système
- **Connexion Internet** : Pour télécharger les paquets et binaires
- **Espace disque** : ~3-5 GB pour tous les outils

## Dépannage

### Permission denied Docker
```bash
sudo usermod -aG docker $USER
# Déconnectez/reconnectez ou: newgrp docker
```

### Outil non trouvé après installation
```bash
# Rechargez votre profil shell
source ~/.bashrc
# ou
source ~/.zshrc
```

### Consulter les logs
```bash
cat /tmp/devops-tools-install.log
```

### Mode debug
```bash
./install-devops-tools.sh -v --dry-run
```

## Ajouter un Nouvel Outil

1. Créez un script `scripts/install-mon-outil.sh` :

```bash
#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

install_mon_outil() {
    print_info "Installing Mon Outil..."
    if command_exists mon_outil; then
        print_success "Mon Outil is already installed"
        return 0
    fi
    # Commandes d'installation ici
}
install_mon_outil
```

2. Rendez-le exécutable : `chmod +x scripts/install-mon-outil.sh`
3. Ajoutez-le dans le tableau `PACKS` du script principal
4. Ajoutez les dépendances éventuelles dans le tableau `DEPENDENCIES`

## Licence

MIT License - Voir [LICENSE](LICENSE) pour plus de détails