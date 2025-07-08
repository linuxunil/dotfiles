# Gemini Agent Context

This document summarizes key information about the user, their preferences, and the project to ensure consistent and effective assistance.

## User & Project Overview

*   **User:** disco
*   **Project:** Neovim configuration located at `/Users/disco/.config/nvim`.
*   **Goal:** Maintain and enhance a modern, performant, and aesthetically pleasing Neovim setup.

## Key Preferences & Aesthetics

*   **Aesthetic:** Cyberpunk theme.
*   **Colorscheme:** `tokyonight` is the preferred theme.
*   **UI Style:** Prefers rounded borders for UI elements.
*   **Keybindings:**
    *   Values specific keybindings like `<S-h>` and `<S-l>` for buffer navigation.
    *   Prefers a mnemonic and consistent keymap layout, managed centrally via `which-key.lua`.
    *   The user prefers `<leader>e` to open the file explorer.
*   **Starter Page:** Likes a custom, themed starter page with ASCII art and relevant quotes that match the overall aesthetic.
*   **Configuration Style:** Prefers clean, maintainable configurations that avoid setting default values.
* **Make sure tools are modern and up todate. Ensure they use the correct repositoryies.

## Technical Environment

*   **OS:** macOS and Fedora 42
*   **Terminal:** `ghostty`
    *   The user maintains a custom configuration for Ghostty at `~/.config/ghostty/config`.
    *   This configuration should be kept in sync with the Neovim theme (`tokyonight`).
*   **Core Neovim Plugins:**
    *   **Plugin Manager:** `lazy.nvim`
    *   **Core Suite:** `mini.nvim` is used extensively for UI (statusline, tabline, starter) and editing functions.
    *   **Fuzzy Finder:** `telescope.nvim`
    *   **Formatting:** `conform.nvim`
    *   **UI:** `noice.nvim` for a modern command line and message experience.
    *   **File Explorer:** `oil.nvim` is the preferred file explorer.

## Interaction Notes

*   **Be Direct:** The user appreciates directness and honesty. Admit mistakes and correct them without making excuses.
*   **Verify First:** Avoid making assumptions about configurations or valid settings for external tools like `ghostty`. Use documentation or the tools themselves to verify settings before recommending them.
*   **Respect Choices:** While proactive recommendations are welcome, always respect the user's final decision and be prepared to revert changes if requested.
