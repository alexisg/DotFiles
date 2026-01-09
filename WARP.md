# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing shell configuration files (zsh/bash), custom scripts, and setup automation for macOS. The files are stored centrally (on Dropbox) and symlinked to their standard locations in the home directory.

## Setup and Deployment

### Initial Setup on New Machine
Run the setup script to install dependencies and apps:
```bash
chmod 755 mac-first-time-setup.sh
./mac-first-time-setup.sh
```

This script installs:
- Xcode CLI tools
- Homebrew
- Oh-My-Zsh
- Mac App Store CLI (mas)
- NVM (Node Version Manager)
- Various applications via brew cask and mas

### Creating Symlinks
After cloning, create symbolic links to activate the dotfiles:
```bash
ln -s ~/Dropbox/Documents/DotFiles/zshrc ~/.zshrc
ln -s ~/Dropbox/Documents/DotFiles/zprofile ~/.zprofile
```

Then reload the shell configuration:
```bash
source ~/.zshrc
```

## Repository Structure

### Shell Configuration
- **zshrc**: Interactive shell configuration (aliases, prompt customization, Oh-My-Zsh settings)
- **zprofile**: Login shell configuration (environment variables, PATH setup, tool initialization)

### Key Components
- **mac-first-time-setup.sh**: Automated setup script for new macOS machines

## Shell Environment Architecture

### Tool Management
The environment uses version managers rather than system-level installations:
- **Node/npm**: Managed via NVM (Node Version Manager)
- **Python**: Managed via pyenv
- **Go**: Previously used GVM (currently commented out in zprofile)
- **Package Managers**: yarn, pnpm, bun

### PATH Configuration
PATH modifications happen in `zprofile` (login shells):
1. Homebrew binaries (`/opt/homebrew/bin`)
2. pnpm global packages (`~/Library/pnpm`)
3. Bun binaries (`~/.bun/bin`)
4. Yarn binaries (`~/.yarn/bin`)
5. Local sbin (`/usr/local/sbin`)

### Auto-Activation
The shell automatically activates the correct Node version when entering directories with `.nvmrc` files (via `nvm use 2>/dev/null` in zshrc).

## Custom Aliases and Functions

### Git Workflow Aliases
The configuration uses **rebase-based pulls** as the default:
- `pull` = `git pull --rebase --stat`
- `abort` = `git rebase --abort` (for failed rebases)
- `co` = `git checkout`
- `ci` = `git commit -a -m`
- `stat` = `git status`

### Multi-Repository Git Function
`gg <command>`: Runs git commands recursively across repositories in subdirectories (searches for .git directories 1-2 levels deep)

Example: `gg status` shows status for all repos in current directory

### Custom Log Views
- `logall`: View all commits from last week with graph and stats
- `loga`: Filter commits by author "Alexis"
- `logj`: Filter commits by author "jarques"

### Yarn Shortcuts
- `yi` = yarn
- `ys` = yarn start
- `yb` = yarn build
- `yd` = yarn dev
- `yis` = yarn install --force && yarn start

### Editor Aliases
- `code`: Points to Cursor app (not VS Code)
- `sub`: Opens files in Sublime Text
- `profile`: Opens zshrc in code editor
- `so`: Sources (reloads) zshrc

## Custom Prompt Configuration

Uses Oh-My-Zsh with "agnoster" theme, customized with a random emoji selector that displays one of: 💩 💇 🐸 🐵 🦄 🌈

## Development Server Utilities

- `simpleserve`: Python HTTP server on port 8000
- `es`: Eleventy serve
- `https-server`: Function to start http-server with local SSL certificates (requires certificates in `~/.localhost-ssl/`)
- `ks`: Kill all Node processes

## Important Notes for Editing

When modifying shell configuration:
1. Changes to `zprofile` (environment/PATH) require a new login shell or terminal restart
2. Changes to `zshrc` (aliases/functions) can be reloaded with `source ~/.zshrc` or the `so` alias
3. Files are symlinked from Dropbox, so edits must be made to the source files in this repository
4. The Cursor IDE is aliased as `code` command (not VS Code)

## Git Configuration

Default git config is set in `mac-first-time-setup.sh`:
- User: Alexis Gallisá
- Email: alexis@alexisgallisa.com

Git completion is provided by Oh-My-Zsh's git plugin.
