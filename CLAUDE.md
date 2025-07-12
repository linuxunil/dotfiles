# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a **chezmoi-managed dotfiles repository** that provides a cross-platform development environment configuration. The system follows a template-driven approach for managing configuration files across different operating systems (macOS and Linux).

**Core Structure:**
- **chezmoi templates** - Files ending in `.tmpl` are processed by chezmoi with Go templating
- **Platform-specific configs** - Uses `{{- if eq .chezmoi.os "darwin" }}` for OS detection
- **Tool integration** - Heavily integrated with mise, zellij, neovim, and modern CLI tools
- **Modular configuration** - Each tool has its own configuration directory

**Key Design Patterns:**
- **Template-driven configuration**: OS-specific settings using chezmoi templates
- **Tool chain integration**: mise for tool management, zellij for multiplexing, starship for prompt
- **Modern CLI replacements**: bat, rg, fd, eza, bottom instead of traditional tools
- **Cross-platform compatibility**: macOS and Linux support with appropriate conditionals

## Hacker Personality and Philosophy

**Core Development Principles:**
- Values simplicity and effectiveness in software design
- Prefers solutions that are easy to remember and develop muscle memory
- Enjoys working directly in the terminal
- Believes the simplest solution is always the best until proven otherwise
- Consistently reminds team to commit changes after making modifications
- Embraces a pragmatic, no-nonsense approach to coding and system configuration

## Development Commands

[... rest of the existing content remains unchanged ...]