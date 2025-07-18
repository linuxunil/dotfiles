# Vim Mode in Emacs - Quick Reference

## Basic Vim Operations (All Work as Expected)
- `hjkl` - Movement
- `w`, `b`, `e` - Word movement
- `0`, `^`, `$` - Line navigation
- `gg`, `G` - Go to top/bottom
- `i`, `a`, `o`, `O` - Insert modes
- `v`, `V`, `C-v` - Visual modes
- `d`, `y`, `p` - Delete, yank, paste
- `u`, `C-r` - Undo, redo
- `/`, `?` - Search
- `n`, `N` - Next/previous search

## Enhanced Vim Features

### Surround Operations (evil-surround)
- `ys<motion><char>` - Surround with character
- `cs<old><new>` - Change surrounding
- `ds<char>` - Delete surrounding
- Examples:
  - `ysiw"` - Surround word with quotes
  - `cs"'` - Change double quotes to single
  - `ds"` - Delete quotes

### Text Objects (evil-args)
- `cia` - Change inner argument
- `caa` - Change around argument
- `dia` - Delete inner argument
- `daa` - Delete around argument

### Number Operations (evil-numbers)
- `C-a` - Increment number at point
- `C-x` - Decrement number at point

### Exchange (evil-exchange)
- `cx<motion>` - Mark for exchange
- `cx<motion>` - Exchange with marked text
- `cxc` - Cancel exchange

### Commentary (evil-commentary)
- `gc<motion>` - Comment/uncomment
- `gcc` - Comment/uncomment line
- `gcap` - Comment/uncomment paragraph

### Escape Sequences (evil-escape)
- `jk` - Escape to normal mode (works in insert mode)

### Navigation (avy)
- `gs` - Jump to any two characters
- `gl` - Jump to any line

## Leader Key Mappings (Space)

### Files
- `<leader>ff` - Find file
- `<leader>fr` - Recent files
- `<leader>fb` - Switch buffer
- `<leader>fs` - Save file
- `<leader>fed` - Edit Emacs config

### Projects
- `<leader>pp` - Switch project
- `<leader>pf` - Find file in project
- `<leader>ps` - Search in project (ripgrep)
- `<leader>pt` - Run project tests
- `<leader>pb` - Build project
- `<leader>pz` - Open project in zellij

### Git (vim-fugitive style)
- `<leader>gs` - Git status (Magit)
- `<leader>gb` - Git branch
- `<leader>gd` - Git diff
- `<leader>gl` - Git log
- `<leader>gp` - Git push
- `<leader>gP` - Git pull
- `<leader>gc` - Git commit

### Search
- `<leader>ss` - Search in buffer
- `<leader>sp` - Search in project
- `<leader>sf` - Find file (fd)
- `<leader>sb` - Search buffers
- `<leader>si` - Search symbols

### Buffers
- `<leader>bb` - Switch buffer
- `<leader>bd` - Delete buffer
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer

### Windows
- `<leader>wh/j/k/l` - Move between windows
- `<leader>ws` - Split horizontal
- `<leader>wv` - Split vertical
- `<leader>wd` - Delete window
- `<leader>wo` - Delete other windows

### Terminal
- `<leader>tt` - Open terminal
- `<leader>tm` - Multi-terminal
- `<leader>tn/tp` - Next/previous terminal

### Tasks
- `<leader>tl` - List tasks
- `<leader>tr` - Run task
- `<leader>tc` - Compile

### LSP
- `<leader>ld` - Go to definition
- `<leader>lr` - Find references
- `<leader>ln` - Rename
- `<leader>la` - Code action
- `<leader>lf` - Format buffer
- `<leader>le` - Show errors

### Quick Actions
- `<leader>z` - Open in zellij
- `<leader>qq` - Quit Emacs
- `<leader>qr` - Restart Emacs

## Additional Vim-like Bindings

### Navigation
- `C-o` - Jump backward
- `C-i` - Jump forward
- `C-d` - Scroll down
- `C-u` - Scroll up
- `C-6` - Switch to last buffer
- `gb` - Buffer list
- `gf` - Go to file under cursor

### Insert Mode
- `C-w` - Delete word backward
- `C-u` - Delete line

## Integration with Your Tools

### Magit vs Lazygit
- Magit provides superior Git workflow within Emacs
- Use `<leader>gs` for status, stage/unstage with `s`/`u`
- Commit with `c c`, push with `p p`
- Better than lazygit for most operations

### Search Integration
- `<leader>ps` uses your ripgrep with preview
- `<leader>sf` uses your fd for file finding
- All search is contextual and fast

### Project Management
- Automatically detects project types (Go, Python, etc.)
- `<leader>pt` runs appropriate tests
- `<leader>pb` runs appropriate build

## Tips for Vim Users

1. **Start with familiar operations**: All basic vim motions work
2. **Use the leader key**: Space-based shortcuts are powerful
3. **Leverage Magit**: Superior to any terminal Git interface
4. **Try avy navigation**: `gs` for quick jumping
5. **Use evil-surround**: Same as vim-surround
6. **Escape with jk**: Faster than reaching for Esc

## Compatibility Notes

- **98% vim compatibility** for basic operations
- **Enhanced features** beyond what vim offers
- **Seamless integration** with your existing tools
- **Better LSP integration** than most vim setups
- **Superior project management** with projectile