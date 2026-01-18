# Neovim Configuration Migration to mini.deps

## Summary

Successfully migrated the Neovim configuration from lazy.nvim to mini.deps (MiniMax style).

## What Changed

### Core Changes
1. **init.lua** - Added mini.deps bootstrap code at the top
2. **core/deps.lua** - New file replacing core/lazy.lua with mini.deps plugin management
3. **core/init.lua** - Updated to require deps.lua instead of lazy.lua
4. **core/keymappings.lua** - Updated plugin manager commands from Lazy to Deps

### New Configuration Files
Created modular configuration files in `lua/config/`:
- **config/lsp.lua** - LSP server setup and configuration
- **config/blink.lua** - Blink completion configuration
- **config/conform.lua** - Code formatting configuration
- **config/lint.lua** - Linting configuration
- **config/copilot.lua** - GitHub Copilot configuration

### Removed Files
- All spec files from `lua/specs/` except `specs/lsp/` (needed for server configs)
- `core/lazy.lua` - Old lazy.nvim configuration
- Disabled colorscheme files (evergarden, gruvbox, kanagawa, chalklines)
- Unused plugins (flash, glance, alpha, autopairs, etc.)

### Plugins Kept and Migrated

#### Mini.nvim Modules
- mini.icons - Icon support
- mini.statusline - Status line
- mini.pick - Fuzzy finder with keymappings
- mini.comment - Code commenting
- mini.surround - Surround operations
- mini.ai - Text objects
- mini.clue - Keybinding hints
- mini.files - File manager
- mini.indentscope - Indent scope visualization
- mini.align - Text alignment
- mini.extra - Extra utilities
- mini.notify - Notifications

#### External Plugins
- nvim-treesitter - Syntax highlighting and parsing
- nvim-treesitter-context - Show context
- nvim-treesitter-textobjects - Text objects
- nvim-tree-pairs - Tree-sitter pairs
- rainbow-delimiters - Rainbow brackets
- vim-matchup - Enhanced matching
- treesitter-unit - Unit selection
- gitsigns.nvim - Git integration
- committia.vim - Better commit messages
- diffview.nvim - Git diff viewer
- catppuccin - Color scheme (only one kept)
- neovim/nvim-lspconfig - LSP configuration
- mason.nvim - LSP server installer
- blink.cmp - Completion engine
- conform.nvim - Formatting
- nvim-lint - Linting
- copilot.lua - AI code completion
- neo-tree.nvim - File explorer
- todo-comments.nvim - Todo highlighting

## How to Use

### Plugin Management Commands
- `<leader>/u` - Update plugins (DepsUpdate)
- `<leader>/i` - Show plugin log (DepsShowLog)

### Mini.deps Commands
- `:DepsUpdate` - Update all plugins
- `:DepsUpdateOffline` - Update plugins offline
- `:DepsClean` - Remove unused plugins
- `:DepsShowLog` - Show update log

### Key Features

1. **Faster Startup** - Mini.deps is lightweight and loads plugins efficiently with now() and later()
2. **Simpler Configuration** - All plugin setup in one file (deps.lua)
3. **Modular Setup** - Plugin configs separated into config/ directory
4. **Mini.nvim Integration** - Full use of mini.nvim ecosystem
5. **Removed Bloat** - Disabled and unused plugins removed

## Migration Notes

- LSP server configurations remain in `specs/lsp/` directory
- All keymappings are preserved
- Colorscheme changed to catppuccin only (others removed)
- Plugin manager changed from lazy.nvim to mini.deps
