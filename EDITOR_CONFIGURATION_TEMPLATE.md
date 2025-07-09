# The Ultimate Editor Configuration Prompt

This template is designed to capture all the necessary details for a perfect, personalized editor setup.

**Objective:** Configure my primary code editor, `[Name of Editor, e.g., Neovim, Doom Emacs, VS Code]`, to be a highly personalized, aesthetic, and efficient development environment.

**1. Core Philosophy & Goal:**
*   **My Goal Is:** `[Describe the end state. e.g., "A lightning-fast, minimalist Go and Rust IDE," or "A beautiful, feature-rich environment for web development that feels like a cyberpunk terminal," or "A stable, keyboard-driven writing and coding setup that prioritizes Org-mode and Git integration."]`
*   **Inspiration:** `[Optional: Link to a dotfiles repository or article that inspires you. e.g., "I want something that feels like ThePrimeagen's setup," or "The general aesthetic of https://github.com/user/dotfiles is what I'm after."]`

**2. The Foundation (System & Editor):**
*   **Operating System(s):** `[e.g., Fedora 42, macOS Sonoma]`
*   **Shell:** `[e.g., zsh]`
*   **Terminal Emulator:** `[e.g., ghostty, WezTerm, Alacritty]`
*   **Editor & Version (if specific):** `[e.g., Neovim (latest stable), Doom Emacs on Emacs 30.1]`

**3. User Interface & Aesthetics (The "Look"):**
*   **Colorscheme:** `[e.g., tokyonight, Catppuccin Mocha, Gruvbox Material]`
*   **Font:**
    *   **Primary Code Font:** `[e.g., JetBrains Mono, Fira Code, Iosevka]`
    *   **Ligatures:** `[e.g., Enabled]`
*   **UI Elements:**
    *   **Statusline/Modeline:** `[e.g., Minimal, showing Git branch, LSP status, and file path. Or, feature-rich like doom-modeline.]`
    *   **Tabline/Bufferline:** `[e.g., I prefer text-based tabs at the top, with nerd-font icons.]`
    *   **File Explorer UI:** `[e.g., A simple tree on the left, like NERDTree or treemacs.]`
    *   **Borders & Windows:** `[e.g., Rounded borders for all floating windows.]`
    *   **Startup Screen/Dashboard:** `[e.g., Yes, show a custom dashboard with my most recent files and some ASCII art.]`

**4. Keybindings & Navigation (The "Feel"):**
*   **Modal Editing Style:** `[e.g., Yes, full Evil-mode/Vim emulation is essential.]`
*   **Leader Key:** `[e.g., <space>]`
*   **Crucial Keybindings:**
    *   File Explorer Toggle: `[e.g., <leader>e]`
    *   Fuzzy Find Files: `[e.g., <leader>ff]`
    *   Fuzzy Find Text (Ripgrep): `[e.g., <leader>fg]`
    *   Buffer Navigation: `[e.g., <S-l> for next, <S-h> for previous]`
    *   Terminal Toggle: `[e.g., <C-'>]`
    *   Comment Toggle: `[e.g., gcc]`

**5. Language-Specific Support (The "Brains"):**
Please configure support for the following languages with these tools:

| Language     | LSP Server      | Formatter   | Linter          | Debugger | Notes                               |
|--------------|-----------------|-------------|-----------------|----------|-------------------------------------|
| `e.g., Go`   | `gopls`         | `gofumpt`   | `golangci-lint` | `delve`  | `Must have go.mod/sum auto-management` |
| `e.g., Rust` | `rust-analyzer` | `rustfmt`   | `clippy`        | `(none)` | `Show inlay hints for types`        |
| `e.g., TS/JS`| `ts_ls`         | `prettier`  | `eslint`        | `(none)` | `Format on save is critical`        |
| `[Language]` | `[LSP]`         | `[Formatter]` | `[Linter]`      | `[DAP]`  | `[Any special requirements]`        |

**6. Tooling & Integrations:**
*   **Version Control:** `[e.g., Deep Magit integration is a must. I also want inline git blame and diffs in the gutter.]`
*   **Note Taking:** `[e.g., Configure org-mode with a custom capture template for TODOs and notes. Store all notes in ~/notes/org.]`
*   **AI/LLM:** `[e.g., Integrate Copilot/Codeium with completions and chat functionality.]`
*   **Snippets:** `[e.g., Enable friendly snippets for common boilerplate in Go and Python.]`

**7. Configuration Management:**
*   **Strategy:** `[e.g., The entire configuration must be managed by chezmoi.]`
*   **Structure:** `[e.g., Please follow the existing structure in my dotfiles repo. For Neovim, use lazy.nvim with files split under lua/custom/plugins/.]`
*   **PATH Management:** `[e.g., Ensure any necessary binaries (like language servers or the editor's own CLI tool) are added to the PATH in my ~/.zshrc file.]`
