# DevOps Tools Installation Script

Ce script installe automatiquement les outils DevOps essentiels sur les distributions Linux les plus courantes utilisées par les professionnels du DevOps.

## Distributions Supportées

- **Ubuntu** (18.04, 20.04, 22.04+)
- **Debian** (10, 11, 12+)
- **CentOS/RHEL** (7, 8, 9)
- **Fedora** (35+)
- **Alpine Linux** (3.15+)
- **Arch Linux** / **Manjaro**
- **openSUSE** Leap / Tumbleweed

## Outils Disponibles

### Outils de Base
- **Git** - Contrôle de version distribué
- **GitHub CLI** - Interface en ligne de commande pour GitHub

### Conteneurisation
- **Docker** - Plateforme de conteneurisation
- **Docker Compose** - Orchestration de conteneurs multi-conteneurs

### Kubernetes
- **kubectl** - CLI pour Kubernetes
- **Helm** - Gestionnaire de paquets pour Kubernetes

### Infrastructure as Code
- **Terraform** - Gestion d'infrastructure
- **Ansible** - Automatisation et configuration

### Cloud CLI
- **AWS CLI** - Interface Amazon Web Services

## Utilisation

### Installation Complète
```bash
./install-devops-tools.sh
```

### Installation Sélective
```bash
# Installer seulement Git et Docker
./install-devops-tools.sh git docker

# Installer des outils spécifiques
./install-devops-tools.sh git docker kubectl terraform
```

### Mode Simulation (Dry Run)
```bash
./install-devops-tools.sh --dry-run
```

### Liste des Outils Disponibles
```bash
./install-devops-tools.sh --list
```

### Aide
```bash
./install-devops-tools.sh --help
```

## Options

| Option | Description |
|--------|-------------|
| `-h, --help` | Affiche le message d'aide |
| `-d, --dry-run` | Simule l'installation sans installer réellement |
| `-v, --verbose` | Active la sortie verbeuse |
| `-l, --list` | Liste les outils disponibles |

## Caractéristiques

### ✅ Détection Automatique
Le script détecte automatiquement votre distribution Linux et adapte les commandes d'installation en conséquence.

### ✅ Gestion des Erreurs
- Vérification de l'existence des commandes avant installation
- Gestion robuste des erreurs avec messages clairs
- Logs détaillés pour le dépannage

### ✅ Sécurité
- Utilisation des dépôts officiels
- Vérification des clés GPG
- Permissions appropriées

### ✅ Flexibilité
- Installation complète ou sélective
- Mode dry-run pour les tests
- Support multi-architectures (x86_64, ARM64)

## Prérequis

- Système Linux supporté
- Accès sudo pour l'installation
- Connexion internet pour télécharger les paquets

## Post-Installation

1. **Redémarrez votre terminal** ou sourcez votre fichier de configuration :
   ```bash
   source ~/.bashrc  # ou ~/.zshrc
   ```

2. **Configurez vos identifiants cloud** :
   ```bash
   aws configure
   ```

3. **Vérifiez les installations** :
   ```bash
   git --version
   docker --version
   kubectl version --client
   # ... etc
   ```

4. **Docker Group** (si Docker installé) :
   Vous devrez peut-être vous déconnecter et vous reconnecter pour que les changements de groupe prennent effet.

## Logs

Le script génère un fichier de log détaillé dans `/tmp/devops-tools-install.log` pour faciliter le dépannage.

## Dépannage

### Problèmes Communs

1. **Permission refusée** : Assurez-vous d'avoir les droits sudo
2. **Dépôt introuvable** : Vérifiez votre connexion internet
3. **Conflit de versions** : Le script détecte et évite les réinstallations

### Solutions

- Utilisez `--dry-run` pour tester avant installation
- Consultez le fichier de log pour les erreurs détaillées
- Exécutez avec `sudo` uniquement si nécessaire

## Exemples d'Utilisation

### Développeur Web
```bash
./install-devops-tools.sh git docker gh
```

### Ingénieur Cloud
```bash
./install-devops-tools.sh git terraform aws-cli kubectl helm
```

### Administrateur Système
```bash
./install-devops-tools.sh git ansible docker terraform
```

## Contribuer

Pour ajouter le support d'outils supplémentaires ou de nouvelles distributions :

1. Clonez le dépôt
2. Ajoutez la fonction d'installation dans le script
3. Testez sur les distributions cibles
4. Soumettez une pull request

## Licence

Ce script est distribué sous licence MIT.