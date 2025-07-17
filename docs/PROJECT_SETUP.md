# Quick Project Setup - Built-in Tools Only

Simple project creation using language built-in tools. No custom templates, no complexity.

## Go Projects

```bash
# Basic Go project
mkdir myproject && cd myproject
go mod init github.com/username/myproject
echo 'package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}' > main.go
go run main.go

# CLI app with Cobra
go install github.com/spf13/cobra-cli@latest
cobra-cli init myapp
cd myapp && go mod tidy

# Web API
mkdir myapi && cd myapi
go mod init github.com/username/myapi
go get github.com/gin-gonic/gin
```

## Python Projects

```bash
# Modern Python with uv (recommended)
uv init myproject
cd myproject
uv add requests
uv run python -m myproject

# Traditional Python
mkdir myproject && cd myproject
python -m venv venv
source venv/bin/activate  # or: venv\Scripts\activate on Windows
pip install requests

# Poetry (if preferred)
poetry new myproject
cd myproject && poetry install
```

## Node.js Projects

```bash
# Basic Node.js
mkdir myproject && cd myproject
pnpm init
pnpm add express
echo 'console.log("Hello, World!");' > index.js
node index.js

# TypeScript
mkdir myproject && cd myproject
pnpm init
pnpm add -D typescript @types/node tsx
pnpm tsc --init

# Web frameworks
pnpm create next-app myapp      # Next.js
pnpm create vite myapp          # Vite
pnpm create svelte myapp        # SvelteKit
```

## Rust Projects

```bash
# Basic Rust
cargo new myproject
cd myproject && cargo run

# Library
cargo new --lib mylib
cd mylib && cargo test

# Web API
cargo new myapi
cd myapi
cargo add tokio axum
```

## Quick Reference

### Task Helpers
```bash
task new-go        # Show Go setup commands
task new-python    # Show Python setup commands  
task new-node      # Show Node.js setup commands
task new-web       # Show web project commands
```

### Shell Functions (if you want them)
Add to your `.zshrc`:

```bash
# Go project
go-new() {
    mkdir -p "$1" && cd "$1"
    go mod init "github.com/$(whoami)/$1"
    echo 'package main

import "fmt"

func main() {
    fmt.Println("Hello, '"$1"'!")
}' > main.go
    go run main.go
}

# Python project  
py-new() {
    uv init "$1" && cd "$1"
    uv add --dev pytest ruff mypy
}

# Node.js project
node-new() {
    mkdir -p "$1" && cd "$1"
    pnpm init
    echo 'console.log("Hello, '"$1"'!");' > index.js
    node index.js
}
```

### Usage
```bash
go-new myapi       # Creates Go project
py-new myapp       # Creates Python project
node-new myservice # Creates Node.js project
```

## Why Built-in Tools?

- ✅ **Zero dependencies**: Always available
- ✅ **Official**: Maintained by language teams
- ✅ **Simple**: No custom templates to maintain
- ✅ **Flexible**: Easy to customize per project
- ✅ **Standard**: Everyone knows these commands
- ✅ **Reliable**: Won't break with updates

## Language-Specific Best Practices

### Go
- Use `go mod init` with your GitHub username
- Follow standard project layout: `cmd/`, `internal/`, `pkg/`
- Use `go install` for tools, `go get` for dependencies

### Python
- Use `uv` for modern Python projects (fastest)
- Use `poetry` for complex dependency management
- Use `venv` for simple/traditional projects

### Node.js
- Use `pnpm` for better performance and disk usage
- Use framework generators for web projects
- Use `tsx` for TypeScript development

### Rust
- Use `cargo new` for everything
- Use `--lib` for libraries
- Use workspaces for multi-crate projects

Keep it simple, use what the language provides!