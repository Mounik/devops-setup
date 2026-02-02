# DevOps Tools Installation Script

🚀 **Script d'installation automatisée des outils DevOps essentiels**

## 📋 Description

Ce projet contient un script Bash complet pour installer et configurer automatiquement tous les outils DevOps nécessaires sur votre poste de travail. Que vous soyez sur Linux, macOS ou Windows, ce script adapte l'installation selon votre système d'exploitation.

## ✨ Fonctionnalités

- 🔄 **Multi-plateformes**: Support Linux (Debian/Ubuntu, RedHat/Fedora, Arch), macOS et Windows
- 🎯 **Installation sélective**: Choisissez les outils à installer
- 🔍 **Mode simulation**: Testez sans rien installer
- 📊 **Validation automatique**: Vérifie que chaque outil est bien installé
- 📝 **Logs détaillés**: Suivez l'installation pas à pas
- 🛡️ **Gestion des erreurs**: Arrêt propre en cas d'échec

## 🛠️ Outils Supportés

### 📦 Essentiels
- **Git** - Contrôle de version
- **Docker & Docker Compose** - Conteneurisation
- **Kubernetes (kubectl)** - Orchestration
- **Terraform** - Infrastructure as Code
- **Ansible** - Automatisation et configuration
- **AWS CLI** - Interface AWS

### 🔐 Sécurité & Testing
- **Vault** - Gestion des secrets (HashiCorp)
- **Trivy** - Scanner de vulnérabilités (Aqua Security)
- **Checkov** - Scanner de sécurité infrastructure
- **k6** - Performance testing
- **Newman** - API testing (Postman collections)

### 🔧 Langages de Développement
- **Node.js** - Runtime JavaScript avec npm
- **Rust** - Langage de programmation système performant
- **PHP** - Langage de script web
- **Python 3** - Langage de programmation avec pip
- **uv** - Installateur Python ultra-rapide (Astral)
- **Go** - Langage de programmation compilé
- **Composer** - Gestionnaire de paquets PHP
- **Yarn** - Gestionnaire de paquets JavaScript
- **NVM** - Node Version Manager

### 🛠️ Utilitaires DevOps
- **jq & yq** - Manipulation JSON/YAML
- **Helm** - Package manager Kubernetes

[Voir la liste complète →](devops-tools-list.md)

## 🚀 Installation Rapide

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
./install-devops-tools.sh testing     # Outils de testing et performance
./install-devops-tools.sh languages    # Langages de développement
./install-devops-tools.sh essential    # Git, Docker, kubectl, Terraform, Ansible

# Installation d'outils spécifiques
./install-devops-tools.sh git docker kubectl terraform ansible
```

## 📖 Utilisation

### Options Disponibles

```bash
Options:
  -h, --help          Affiche l'aide
  -d, --dry-run       Simulation sans installation
  -v, --verbose       Mode verbeux
  -t, --tools TOOLS   Installation sélective
  --essential         Outils essentiels uniquement
```

### Exemples d'Utilisation

```bash
# Installation complète
./install-devops-tools.sh

# Installation par packs
./install-devops-tools.sh tools        # Pack DevOps
./install-devops-tools.sh security     # Pack Sécurité
./install-devops-tools.sh testing     # Pack Testing
./install-devops-tools.sh languages    # Pack Langages

# Installation sélective
./install-devops-tools.sh git docker kubectl terraform

# Simulation
./install-devops-tools.sh --dry-run full
./install-devops-tools.sh --dry-run tools

# Lister les packs et outils disponibles
./install-devops-tools.sh --list
```

## 📁 Structure du Projet

```
setup-devops/
├── README.md                   # Ce fichier
├── install-devops-tools.sh     # Script principal d'orchestration
├── scripts/                    # Scripts d'installation individuels
│   ├── install-git.sh          # Installation de Git
│   ├── install-docker.sh       # Installation de Docker
│   ├── install-gh.sh           # Installation de GitHub CLI
│   ├── install-kubectl.sh      # Installation de kubectl
│   ├── install-terraform.sh    # Installation de Terraform
│   ├── install-aws-cli.sh      # Installation de AWS CLI
│   ├── install-ansible.sh      # Installation d'Ansible
│   ├── install-helm.sh         # Installation de Helm
│   ├── install-nodejs.sh       # Installation de Node.js
│   ├── install-rust.sh         # Installation de Rust
│   ├── install-php.sh          # Installation de PHP
│   ├── install-python.sh       # Installation de Python et uv
│   ├── install-composer.sh     # Installation de Composer
│   ├── install-yarn.sh         # Installation de Yarn
│   ├── install-nvm.sh          # Installation de NVM
│   └── install-go.sh           # Installation de Go
│   ├── install-vault.sh         # Installation de Vault
│   ├── install-trivy.sh         # Installation de Trivy
│   ├── install-checkov.sh       # Installation de Checkov
│   ├── install-k6.sh            # Installation de k6
│   └── install-newman.sh        # Installation de Newman
└── logs/                       # Logs d'installation (créés automatiquement)
```

## 🎯 Outils Installés par Catégorie

### 🔧 Conteneurisation & Orchestration
- Docker, Docker Compose, Kubernetes (kubectl), Helm

### ☁️ Cloud & Infrastructure
- AWS CLI, Terraform, Ansible, Pulumi

### 🔍 Sécurité & Testing
- Vault, Trivy, k6, Newman, Checkov

### 🛠️ Développement & Utilitaires
- jq, yq, curl, wget, htop, vim

### 🎨 Fonts & Terminal
- Cascadia Code Nerd Font avec configuration automatique

### 💻 Langages & Runtimes
- Node.js avec npm et Yarn
- Rust avec toolchain complète
- PHP avec Composer et extensions
- Python 3 avec pip et uv (Astral)
- Go avec toolchain complète
- NVM pour gestion multi-versions Node.js

## 📋 Prérequis

- **Système**: Debian/Ubuntu (actuellement)
- **Packages**: curl, wget, unzip (installés automatiquement)
- **Permissions**: Accès sudo pour installations système
- **Espace disque**: ~2GB pour tous les outils

## 🔧 Personnalisation

### Ajouter de Nouveaux Outils

1. Créez un script d'installation individuel dans `scripts/install-mon-outil.sh`:

```bash
#!/bin/bash
# Mon Outil Installation Script
set -euo pipefail

# [Copiez le template d'un script existant]

install_mon_outil() {
    print_info "Installing Mon Outil..."
    # Commandes d'installation ici
    print_success "Mon Outil installed successfully"
}

install_mon_outil
```

2. Rendez-le exécutable: `chmod +x scripts/install-mon-outil.sh`
3. Ajoutez-le au script principal dans la section PACKS ou TOOLS
4. Mettez à jour le README et la documentation

### Configuration Personnalisée

Créez un fichier `.devops-config` pour vos préférences:

```bash
# .devops-config
TOOLS_TO_INSTALL="git,docker,kubectl,terraform,aws"
SKIP_TOOLS="jenkins,prometheus"
CUSTOM_VERSIONS="terraform=1.5.0,kubectl=1.28.0"
```

## 🚨 Dépannage

### Problèmes Courants

**Permission denied Docker:**
```bash
sudo usermod -aG docker $USER
# Déconnectez/reconnectez ou exécutez: newgrp docker
```

**AWS CLI non trouvé:**
```bash
# Vérifiez le PATH
echo $PATH | tr ':' '\n' | grep -E "(aws|local)"
# Ajoutez au .bashrc/.zshrc si nécessaire
export PATH="$PATH:/usr/local/bin"
```

**Terraform version incompatible:**
```bash
# Installez une version spécifique
wget https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip
```

### Mode Debug

```bash
# Mode verbeux pour diagnostiquer
./install-devops-tools.sh -v --dry-run

# Consultez les logs
cat /tmp/devops-install-*.log
```

## 🤝 Contribution

Les contributions sont les bienvenues !

1. Forkez le projet
2. Créez une branche: `git checkout -b feature/nouvel-outil`
3. Ajoutez votre outil
4. Testez sur différents systèmes
5. Soumettez une Merge Request

### Guidelines de Contribution

- Suivez le style de code existant
- Ajoutez des tests de validation
- Documentez les nouveaux outils
- Testez sur au moins 2 systèmes d'exploitation

## 📊 Roadmap

- [ ] Interface interactive (menu graphique)
- [ ] Support containers (Docker image du script)
- [ ] Tests automatisés multi-plateformes
- [ ] Gestionnaire de versions intégré (tfenv, nvm, etc.)
- [ ] Support complet des écosystèmes de développement (Node.js, Python, PHP, Go)
- [ ] Configuration par profil (développeur, ops, sécurité)
- [ ] Integration CI/CD pour validation du script

## 📄 Licence

MIT License - Voir [LICENSE](LICENSE) pour plus de détails

## 👥 Contributeurs

- [@Mounik](https://gitlab.com/Mounik) - Créateur et mainteneur

## 🙏 Remerciements

- Communauté open-source pour les outils incroyables
- [HashiCorp](https://hashicorp.com/) pour Terraform, Vault, etc.
- [Docker](https://docker.com/) pour la conteneurisation
- [Kubernetes](https://kubernetes.io/) pour l'orchestration

## 📞 Support

- **Issues**: [Créer une issue sur GitLab](https://gitlab.com/Mounik/setup-devops/-/issues)
- **Discussions**: [Forum GitLab](https://gitlab.com/Mounik/setup-devops/-/issues)
- **Email**: devops@example.com

---

**⭐ Star ce repository si vous le trouvez utile !**

## 🎨 Cascadia Code Nerd Font

Le script installe automatiquement **Cascadia Code Nerd Font** avec configuration système complète:

### 🚀 Installation automatique
- **Linux**: GNOME Terminal, Tilix, Kitty, Alacritty
- **macOS**: Terminal.app, Kitty (iTerm2 manuel)
- **Windows**: Windows Terminal, PowerShell

### ✨ Caractéristiques
- Icônes Git et DevOps intégrées
- Ligatures de programmation
- Support complet des glyphes
- Activation automatique

[Voir la documentation →](docs/FONTS.md)

---

Made with ❤️ for the DevOps community