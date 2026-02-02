# AGENTS.md

## Script d'Installation des Outils DevOps

### Overview
Script d'automatisation pour l'installation et la configuration de l'ensemble des outils DevOps essentiels utilisés dans le projet.

### Outils à Installer

#### 1. Outils de Version Control
- **Git**: Système de contrôle de version distribué
- **GitHub CLI**: Interface en ligne de commande pour GitHub

#### 2. Outils de Conteneurisation
- **Docker**: Plateforme de conteneurisation
- **Docker Compose**: Orchestration de conteneurs multi-conteneurs
- **Kubernetes**: Orchestration de conteneurs (kubectl)

#### 3. Outils CI/CD
- **Jenkins**: Serveur d'intégration continue
- **GitLab CI**: Pipeline d'intégration continue
- **GitHub Actions**: Workflows d'automatisation

#### 4. Infrastructure as Code
- **Terraform**: Gestion d'infrastructure
- **Ansible**: Automatisation et configuration
- **Pulumi**: Infrastructure as Code avec langages de programmation

#### 5. Monitoring et Logging
- **Prometheus**: Système de monitoring
- **Grafana**: Visualisation de métriques
- **ELK Stack**: Elasticsearch, Logstash, Kibana

#### 6. Cloud CLI Tools
- **AWS CLI**: Interface Amazon Web Services
- **Azure CLI**: Interface Microsoft Azure
- **gcloud**: Interface Google Cloud Platform

#### 7. Outils de Sécurité
- **Vault**: Gestion de secrets
- **OpenSCAP**: Outils de scan de sécurité
- **Trivy**: Scanner de vulnérabilités

#### 8. Outils de Réseau
- **k6**: Testing de performance
- **Postman**: Testing d'API
- **Wireshark**: Analyse réseau

#### 9. Outils de Terminal et Interface
- **Nerd Fonts**: Polices avec icônes pour terminaux
- **Oh My Zsh**: Framework de configuration Zsh
- **Starship**: Prompt minimaliste et personnalisable
- **Tmux**: Multiplexeur de terminal

#### 10. Langages de Développement et Gestionnaires de Paquets
- **Node.js**: Runtime JavaScript avec npm
- **PHP**: Langage de script web avec extensions
- **Python**: Python 3 avec pip gestionnaire de paquets
- **uv**: Installateur Python ultra-rapide d'Astral
- **Composer**: Gestionnaire de paquets PHP
- **Yarn**: Gestionnaire de paquets JavaScript alternatif
- **NVM**: Node Version Manager pour gérer multiples versions Node.js
- **Go**: Langage de programmation Go avec toolchain

### Structure du Script

```bash
#!/bin/bash

# install-devops-tools.sh
# Script d'installation automatisée des outils DevOps

set -e

# Fonctions d'installation
install_git() {
    echo "Installation de Git..."
    # Commandes d'installation
}

install_docker() {
    echo "Installation de Docker..."
    # Commandes d'installation
}

# Fonction principale
main() {
    echo "Début de l'installation des outils DevOps..."

    # Vérification du système
    check_system

    # Installation séquentielle des outils
    install_git
    install_docker
    install_nodejs
    install_php
    install_python
    # ... autres installations

    echo "Installation terminée!"
}

main "$@"
```

### Configuration Post-Installation

#### Variables d'Environnement
- Configuration des PATH pour chaque outil
- Variables d'environnement pour les clés API

#### Fichiers de Configuration
- `.bashrc` ou `.zshrc` modifications
- Fichiers de configuration par outil
- Scripts d'initialisation

### Validation

#### Tests de Vérification
```bash
# Tests de fonctionnalité
test_git_installation() {
    git --version
}

test_docker_installation() {
    docker --version
    docker run hello-world
}
```

### Maintenance

#### Mises à Jour
- Script de mise à jour automatique
- Vérification des versions
- Nettoyage des anciennes installations

### Documentation

#### Logs d'Installation
- Fichier de log détaillé
- Rapport d'installation
- Gestion des erreurs

### Sécurité

#### Bonnes Pratiques
- Vérification des checksums
- Installation depuis sources officielles
- Permissions appropriées
- Isolation des environnements

### Personnalisation

#### Flags et Options
- `--dry-run`: Simulation sans installation
- `--tools-only`: Installation d'outils spécifiques
- `--config-only`: Configuration uniquement
- `--version`: Affichage des versions installées

### Exemples d'Utilisation

```bash
# Installation complète
./install-devops-tools.sh

# Installation sélective
./install-devops-tools.sh git docker kubectl terraform aws-cli ansible helm

# Installation des langages de développement
./install-devops-tools.sh nodejs php python uv nvm go

# Simulation
./install-devops-tools.sh --dry-run
```

### Dépannage

#### Problèmes Courants
- Conflits de versions
- Problèmes de permissions
- Dépendances manquantes
- Configuration réseau

#### Solutions
- Mode verbose pour debugging
- Rollback automatique en cas d'erreur
- Logs détaillés pour investigation

### Roadmap

#### Améliorations Futures
- Support multi-plateformes (Linux, macOS, Windows)
- Interface interactive
- Gestionnaire de paquets intégré
- Tests automatisés post-installation
- Support des versions spécifiques pour chaque langage
- Configuration automatique des environnements de développement