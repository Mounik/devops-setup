# Fonts Configuration Documentation

## Cascadia Code Nerd Font Installation

### Overview
Cascadia Code Nerd Font est une police d'écriture moderne conçue par Microsoft, enrichie avec les icônes Nerd Font pour un affichage optimal dans les terminaux.

### Caractéristiques
- ✨ Support des glyphes de programmation
- 🎨 Icônes Nerd Font intégrées (Git, DevOps, etc.)
- 👁️ Lisibilité optimale
- 🔄 Support ligatures pour le code

### Configuration par Système

#### Linux
- **Installation système**: `/usr/share/fonts/truetype/cascadia-code/`
- **Configuration automatique**: GNOME Terminal, Tilix, Kitty, Alacritty
- **Cache font**: `fc-cache -fv`

#### macOS
- **Installation utilisateur**: `~/Library/Fonts/`
- **Terminal.app**: Configuration automatique via defaults
- **iTerm2**: Configuration manuelle requise

#### Windows
- **Installation**: `%LOCALAPPDATA%/Microsoft/Windows/Fonts/`
- **Windows Terminal**: Configuration automatique via PowerShell
- **PowerShell**: Support natif

### Terminaux Supportés

| Terminal | Auto-Config | Manual Required |
|----------|-------------|----------------|
| GNOME Terminal | ✅ | ❌ |
| Tilix | ⚠️ | ✅ |
| Kitty | ✅ | ❌ |
| Alacritty | ✅ | ❌ |
| Terminal.app | ✅ | ❌ |
| iTerm2 | ❌ | ✅ |
| Windows Terminal | ✅ | ❌ |
| PowerShell | ✅ | ❌ |

### Validation
```bash
# Vérifier la font installée
fc-list | grep -i "Cascadia Code"

# Tester dans le terminal
echo "🚀 DevOps ✨ Docker 🐳 Kubernetes ☸️"
```

### Résolution de Problèmes

#### Font non visible
```bash
# Recharger le cache des fonts
sudo fc-cache -fv

# Redémarrer le terminal
```

#### Configuration iTerm2 manuelle
1. Préférences → Profiles → Text
2. Font → Change Font
3. Sélectionner "CaskaydiaMono Nerd Font"

#### Configuration Tilix manuelle
1. Préférences → Profiles → Default
2. Text → Custom font
3. Choisir "CaskaydiaMono Nerd Font"