# 🐍 Python Development Cheatsheet

## 📋 **Quick Reference**

### **🎯 Key Prefix: `<leader>p*`**
All Python commands use lowercase `p` for Python development.

---

## 🏃 **Execution & Testing**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>pr` | `uv run %` | Run current Python file with UV |
| `<leader>pt` | `uv run pytest` | Run all tests with pytest |
| `<leader>pc` | `uv run ruff check .` | Check code with Ruff linter |
| `<leader>pf` | `uv run ruff format .` | Format code with Ruff |

### **💡 Quick Start with UV**
```bash
# Create new Python project
mkdir my-python-app && cd my-python-app
uv init
uv add --dev pytest ruff mypy
nvim main.py

# Inside Neovim: <leader>pr to run instantly!
```

---

## 📦 **Package Management (UV)**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>pi` | `uv add ...` | Install package (completes command) |
| `<leader>ps` | `uv sync` | Sync dependencies |
| `<leader>pv` | `uv venv` | Create virtual environment |

### **📦 UV Workflow**
```bash
# Project setup
uv init my-project
cd my-project

# Add dependencies
<leader>pi requests fastapi  # Will run: uv add requests fastapi
<leader>pi --dev pytest     # Will run: uv add --dev pytest

# Sync everything
<leader>ps  # Ensures all dependencies are installed
```

---

## 🌍 **Environment Management**

Python environments are automatically managed by `mise`. When you enter a directory with a `.mise.toml` file, the correct Python version is automatically activated.

---

## 🧪 **REPL Integration**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>pR` | Start REPL | Start Python REPL with UV |
| `<leader>ps` | Send line | Send current line to REPL |
| `<leader>pS` | Send file | Send entire file to REPL |
| `<leader>pm` | Send marked | Send visual selection to REPL |

### **🔄 REPL Workflow**
1. `<leader>pR` - Start Python REPL
2. Write code in your file
3. `<leader>ps` - Send line to REPL (test quickly)
4. `<leader>pS` - Send entire file when ready
5. Visual select code + `<leader>pm` for specific blocks

---

## 📝 **Code Quality & Formatting**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>pc` | Ruff check | Lint code with Ruff |
| `<leader>pf` | Ruff format | Format code with Ruff |
| `<leader>cf` | Format buffer | Format current buffer |

### **⚡ Ruff Configuration**
Auto-configured with:
- **Line length**: 88 characters (Black compatible)
- **Import sorting**: isort-style
- **Auto-fix**: Many issues fixed automatically
- **Fast**: Written in Rust, extremely fast

---

## 📚 **Documentation Generation**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>cg` | Generate docstring | Auto-generate Google-style docstring |

### **📖 Docstring Example**
```python
def calculate_area(radius: float) -> float:
    # Position cursor on function, press <leader>cg
    """Calculate the area of a circle.

    Args:
        radius (float): The radius of the circle.

    Returns:
        float: The area of the circle.
    """
    return 3.14159 * radius ** 2
```

---

## 🔍 **LSP Features (Pyright + Ruff)**

| Key | Command | Description |
|-----|---------|-------------|
| `gd` | Go to definition | Jump to definition |
| `gr` | References | Show all references |
| `K` | Hover docs | Show documentation |
| `<leader>ca` | Code actions | Available actions |
| `<leader>rn` | Rename | Rename symbol |

### **🎯 LSP Configuration**
- **Pyright**: Type checking, IntelliSense, go-to-definition
- **Ruff LSP**: Fast linting and formatting
- **Auto-imports**: Automatic import suggestions
- **Type hints**: Real-time type checking

---

## 🧪 **Testing with Pytest**

### **🚀 Test Structure**
```python
# test_calculator.py
import pytest
from calculator import add, divide

def test_add():
    assert add(2, 3) == 5

def test_divide():
    assert divide(10, 2) == 5

def test_divide_by_zero():
    with pytest.raises(ZeroDivisionError):
        divide(10, 0)
```

### **🧪 Testing Commands**
```bash
<leader>pt              # Run all tests
uv run pytest -v       # Verbose output
uv run pytest test_file.py  # Specific file
uv run pytest -k "test_add" # Specific test
```

---

## 🎯 **Common Workflows**

### **🆕 New Python Project (UV)**
```bash
# Initialize project
uv init my-python-app
cd my-python-app

# Add dependencies
uv add requests fastapi
uv add --dev pytest ruff mypy black

# Start coding
nvim src/my_python_app/__init__.py
# Use <leader>pr to run
```

### **🔧 Code Quality Workflow**
1. Write code
2. `<leader>pc` - Check with Ruff
3. `<leader>pf` - Format with Ruff
4. `<leader>pt` - Run tests
5. `<leader>cg` - Add docstrings
6. Commit changes

### **🧪 TDD Workflow**
1. Write test first
2. `<leader>pt` - Run test (should fail)
3. Write minimal code to pass
4. `<leader>pt` - Run test (should pass)
5. `<leader>pf` - Format code
6. Refactor and repeat

### **📦 Dependency Management**
```bash
# Add new package
<leader>pi numpy pandas  # Interactive add

# Development dependencies
<leader>pi --dev pytest-cov mypy

# Sync environment
<leader>ps

# Update dependencies
uv add package@latest
```

---

## 🐛 **Debugging**

### **🔍 Built-in Debugging**
```python
# Add breakpoint in code
breakpoint()  # Python 3.7+

# Or use pdb
import pdb; pdb.set_trace()
```

### **🔧 Debug with DAP** (if configured)
- Set breakpoints: `<leader>db`
- Start debugging: `<leader>dc`
- Step through: `<leader>di`, `<leader>dO`

---

## ⚙️ **Configuration Files**

### **📄 pyproject.toml** (recommended)
```toml
[tool.ruff]
line-length = 88
target-version = "py311"

[tool.ruff.lint]
select = ["E", "F", "I", "N", "W", "UP"]
ignore = ["E501"]  # Line too long (handled by formatter)

[tool.ruff.format]
quote-style = "double"
indent-style = "space"

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py", "*_test.py"]
```

---

## 📐 **Text Objects & Navigation**

Thanks to `mini.ai` + treesitter (removed vim-pythonsense):

| Key | Description |
|-----|-------------|
| `af` | Around function |
| `if` | Inside function |
| `ac` | Around class |
| `ic` | Inside class |
| `]f` | Next function |
| `[f` | Previous function |
| `]c` | Next class |
| `[c` | Previous class |

---

## 🎨 **Pro Tips**

💡 **UV is fast**: Modern Python package manager, faster than pip
💡 **Ruff is lightning**: Replaces Black, isort, flake8, and more
💡 **Auto-formatting**: Code formats on save automatically
💡 **REPL workflow**: Great for data science and experimentation
💡 **Type hints**: LSP provides excellent type checking
💡 **Environment switching**: Easy with venv-selector
💡 **Docstring automation**: `<leader>cg` generates Google-style docs

### **🔥 Speed Tips**
- Use `<leader>pr` for quick script running
- Use `<leader>ps` to test single lines in REPL
- Use `<leader>pt` for rapid test feedback
- Use `<leader>pc` before committing code

Your Python development is now supercharged with modern tooling! 🚀🐍
