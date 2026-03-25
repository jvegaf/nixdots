# Notas de Migración: dotfiles → nixdots

## Resumen de la Migración

Este documento registra qué configuraciones fueron migradas desde los dotfiles tradicionales (`~/dotfiles/`) hacia la configuración Nix con Home Manager (`~/nixdots/`).

---

## 📂 Configuraciones Migradas

### Shell: Zsh

| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `.zshrc` | `modules/zsh.nix` | ✅ Completo |
| `.zshalias` | `modules/zsh.nix` (shellAliases) | ✅ Completo |
| `.zprofile` | `modules/zsh.nix` (envExtra) | ✅ Completo |
| `.config/zsh/zshvars` | `modules/zsh.nix` (envExtra) | ✅ Completo |
| `.config/zsh/zshrc-custom` | `modules/zsh.nix` (initExtra) | ✅ Completo |

**Elementos Migrados:**
- Instalador de Zinit (nota: ahora usa plugins nativos de zsh)
- Aliases de navegación, git, docker, UV
- Variables de entorno (EDITOR, BROWSER, XDG_*)
- Configuración de historial
- Estilos de completado (zstyle)
- Integraciones: starship, zoxide, fzf-tab
- Keybindings estilo Emacs con vim motions
- Funciones: y(), xterm_title, osc7-pwd

### Terminal: Tmux

| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `.tmux.conf` | `modules/tmux.nix` | ✅ Completo |

**Elementos Migrados:**
- Tema Catppuccin Mocha (colores)
- Prefix: `Alt+a`
- Navegación vim-style con Alt+arrows
- Quick window switching (C-1, C-2, etc.)
- Smart pane switching con vim awareness
- Plugins: vim-tmux-navigator, yank, battery, cpu, net-speed, copycat, pain-control, open, sensible, resurrect, continuum
- Status bar con formato personalizado

### Git

| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `gitconfig` | `modules/git.nix` | ✅ Completo |

**Elementos Migrados:**
- Usuario: Jose Vega <josevega234@gmail.com>
- Delta como pager con tema oscuro
- LFS filter configurado
- GitHub credential helper (gh auth)
- Pull rebase por defecto
- Ignores comunes (.DS_Store, node_modules, etc.)

### Neovim

| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `neovim-config/` (LazyVim) | `modules/neovim.nix` + `modules/nvf-lua/` | ✅ Completo |

**Migración a nvf (NotAShelf/nvf):**

La configuración completa de LazyVim ha sido migrada a nvf:
- **Framework**: LazyVim → nvf (Nix-native)
- **Plugins**: Declarados via `vim.startPlugins` y opciones nativas
- **LSP**: Configurado via `vim.languages.<lang>`
- **Colorscheme**: ayu
- **Completion**: blink.cmp con configuración Lua

**Archivos clave:**
- `modules/neovim.nix` - Configuración principal
- `modules/nvf-lua/blink-cmp.lua` - Configuración de completion
- `old/neovim-config/` - Backup de la configuración anterior (LazyVim)

**LazyVim Extras migradas:**
- AI: sidekick
- Coding: mini-comment, mini-surround, yanky
- DAP: core, nlua
- Editor: aerial, dial, harpoon2, illuminate, inc-rename, mini-diff, outline, refactoring
- Languages: clangd, docker, git, json, markdown, tailwind, toml, typescript
- UI: indent-blankline, smear-cursor
- Utils: dot, mini-hipatterns, project, rest

### Temas y UI

#### GTK
| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `.gtkrc-2.0` | `modules/gtk.nix` | ✅ Completo |
| `.config/gtk-3.0/settings.ini` | `modules/gtk.nix` | ✅ Completo |

**Elementos Migrados:**
- Tema: Breeze-Dark
- Iconos: breeze-dark
- Cursor: capitaine-cursors
- GTK_THEME en sessionVariables

#### Qt
| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `.config/qt5ct/*` | `modules/qt.nix` | ✅ Completo |
| `.config/Kvantum/*` | `modules/qt.nix` | ✅ Completo |

**Elementos Migrados:**
- Plataforma: qt5ct
- Estilo: Breeze-Dark / Kvantum
- Configuraciones de qt5ct y qt6ct

#### Fontconfig
| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `.config/fontconfig/fonts.conf` | `modules/fontconfig.nix` | ✅ Completo |

**Elementos Migrados:**
- Antialiasing: true
- Hinting: hintslight
- Subpixel: rgb
- DPI: 102

### Hyprland

| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `.config/hypr/UserConfigs/UserKeybinds.conf` | `modules/hyprland/binds.nix` | ✅ Completo |
| `.config/hypr/hyprland.conf` | `modules/hyprland/main.nix` | ✅ Completo |

**Elementos Migrados:**
- Atajos de teclado principales
- Atajos de usuario (wallpaper, rofi themes)
- Screenshot binds
- Workspace-to-monitor binds
- Variables de entorno (WAYLAND, QT, GTK)
- Window rules
- Workspace assignments

**Scripts Migrados:**
- `open_books`: Script para abrir libros PDF/epub con wofi

### Aplicaciones

#### Fastfetch
| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `.config/fastfetch/config.jsonc` | `modules/fastfetch/config.jsonc` | ✅ Completo |

#### Wezterm
| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `.wezterm.lua` | `modules/wezterm/config.lua` | ✅ Completo |

#### Bat
| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `.config/bat/themes/*` | `modules/bat.nix` | ✅ Completo |

**Tema:** Catppuccin Macchiato

#### Lazygit
| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `.config/lazygit/config.yml` | `modules/lazygit.nix` | ✅ Completo |

**Configuración:**
- Show icons
- Tema: Catppuccin colors

#### IdeaVim
| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `.ideavimrc` | `modules/ideavim.nix` | ✅ Completo |

**Plugins configurados:**
- highlightedyank
- commentary
- surround
- easymotion
- multiple-cursors
- NERDTree
- vim-sneak

#### Dunst
| Archivo Original | Destino Nix | Estado |
|-----------------|-------------|--------|
| `.config/dunst/dunstrc` | `modules/dunst.nix` | ✅ Completo |

**Tema:** Catppuccin colors (azul para normal, rojo para crítico)

---

## 📋 Archivos NO Migrados (Mantener Externos)

Estos archivos requieren configuración manual o no son compatibles con Nix:

| Archivo | Razón |
|---------|-------|
| `.vimrc` | Migrado a nvf en su lugar |
| `.Xresources` | No usado en Wayland (Hyprland) |
| `.xprofile` | No necesario en Nix |
| `.moc/` | MOC player (reemplazar por ncmpcpp) |
| `.joyfuld/` | Joyfuld (monitoring) |
| `.ugs/` | Usuario gscreener |
| `.face` | Icono de usuario (mantener en $HOME) |
| `.ignore` | Para herramientas específicas |
| `assets/*` | Recursos estáticos |
| `install-scripts/*` | Scripts de instalación |

## 🔧 Cambios Importantes

### 1. Zsh Plugin Manager

**Antes:** Zinit con turbo mode  
**Ahora:** Home Manager zsh integrado + oh-my-zsh snippets

El enfoque de Nix es declarative, no imperative. Los plugins de zsh ahora se configuran via `programs.zsh.plugins` en lugar de zinit.

### 2. Tmux Plugin Manager

**Antes:** TPM (tmux-plugins/tpm)  
**Ahora:** Paquetes Nix (`tmuxPlugins.*`)

Nix proporciona plugins de tmux como derivaciones. No necesitas TPM ni `run '~/.tmux/plugins/tpm/tpm'`.

### 3. Neovim Config (Actualizado)

**Antes:** vim-plug con ~/.vim/plugged  
**Ahora:** nvf (NotAShelf/nvf) - Configuración Nix-native

nvf permite configurar Neovim completamente en Nix:
- Plugins declarados como inputs/derivaciones
- LSP y Treesitter via opciones nativas
- Config Lua para plugins complejos

Para más información, ver `modules/neovim.nix`.

### 4. GTK/Qt Themes

**Antes:** Archivos .ini y .conf  
**Ahora:** Home Manager options + archivos de config

Los themes ahora son más portables y reproducibles.

---

## ✅ Checklist de Migración Completada

- [x] Zsh (aliases, vars, completions)
- [x] Tmux (theme, binds, plugins)
- [x] Git (user, delta, LFS)
- [x] Fastfetch
- [x] Wezterm
- [x] Bat (theme)
- [x] Lazygit
- [x] IdeaVim
- [x] Dunst
- [x] GTK theming
- [x] Qt theming (qt5ct, qt6ct, kvantum)
- [x] Fontconfig
- [x] Hyprland (binds, env, rules)
- [x] Waybar
- [x] Wofi
- [x] Swaync
- [x] Starship
- [x] Fontconfig
- [x] Neovim (nvf migration from LazyVim)

---

## 🐛 Problemas Conocidos

### 1. Delta en Git

El módulo `deltaFeatures` puede requerir ajustes dependiendo de la versión de delta instalada.

**Solución:** Si hay errores, comentar las líneas de `deltaFeatures` en `modules/git.nix`.

### 2. Bat Theme

El fetch de GitHub en `modules/bat.nix` usa un hash placeholder. Actualizar con un hash real.

### 3. Zsh Completions

Los zsh-completions externos pueden requerir ajustes de paths. Verificar que `$fpath` incluya los directorios correctos.

---

## 📝 Notas Técnicas

### Por qué Nix en lugar de Stow?

1. **Reproducibilidad**: La misma config en cualquier máquina
2. **Gestión de dependencias**: Paquetes declarados junto con configs
3. **Rollback**: Fácil volver a un estado anterior
4. **Consistencia**: Todo en un solo lugar

### Alternativas Consideradas

- **Stow**: Gestor de symlinks (lo que usabas antes)
- **GNU Guix**: Sistema declarativo similar
- **Home Manager standalone**: Sin NixOS

---

**Última actualización**: Marzo 2026

---

## 📝 Nota de Migración: neovim-config → nvf (2026-03-25)

### Resumen

Se migró la configuración completa de Neovim desde LazyVim (`neovim-config/`) a **nvf** (NotAShelf/nvf), un framework de configuración de Neovim basado en Nix.

### Cambios Realizados

1. **Agregado nvf como input en `flake.nix`**
2. **Nueva configuración en `modules/neovim.nix`**:
   - Opciones vim básicas traducidas
   - Languages/LSP configurados (TypeScript, Python, Rust, Go, C/C++, Nix, etc.)
   - Treesitter grammars
   - DAP habilitado
   - blink.cmp como completion engine
   - Colorscheme: ayu
   - Keymaps migrados
3. **Archivos Lua en `modules/nvf-lua/`**:
   - `blink-cmp.lua` - Configuración de completion

### Plugins Agregados

- blink.cmp (completion)
- oil.nvim (file explorer)
- nvim-tree.lua
- nvim-toggleterm.lua
- neogit
- diffview.nvim
- telescope.nvim
- harpoon
- mini.surround, mini.comment, mini.diff
- which-key.nvim
- lazydev.nvim

### Languages/LSP Habilitados

- TypeScript/JavaScript (biome formatter)
- Python (ruff formatter)
- Rust, Go, C/C++
- Nix (nixd + nixfmt)
- JSON, HTML, CSS, Markdown
- TOML, YAML
- Docker, Git
- Tailwind CSS

### Para Probar

```bash
cd ~/nixdots
nix run .#homeManagerConfigurations.th3g3ntl3man@fs0ciety.activationPackage
# O rebuild de home-manager
```
