# 🚀 Go Development Cheatsheet

## 📋 **Quick Reference**

### **🎯 Key Prefix: `<leader>G*`**
All Go commands use uppercase `G` to avoid conflicts with Git commands.

---

## 🏃 **Execution & Building**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>Gr` | `:GoRun` | Run current Go file |
| `<leader>GR` | `:GoRun %` | Run current Go file (explicit) |
| `<leader>Gb` | `:GoBuild` | Build Go project |
| `<leader>GB` | `:GoBuild %` | Build current Go file |

### **💡 Quick Start**
```bash
# Create new Go project
mkdir my-go-app && cd my-go-app
go mod init my-go-app
nvim main.go

# Inside Neovim: <leader>Gr to run instantly!
```

---

## 🧪 **Testing & Coverage**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>Gt` | `:GoTest` | Run all tests in package |
| `<leader>GT` | `:GoTestFunc` | Test function under cursor |
| `<leader>Ga` | `:GoTestFile` | Test current file |
| `<leader>GA` | `:GoTestPkg` | Test entire package |
| `<leader>Gc` | `:GoCoverage` | Show test coverage |
| `<leader>GC` | `:GoCoverageClear` | Clear coverage display |

### **🎯 Testing Workflow**
1. Write your function
2. Position cursor on function name
3. `<leader>GE` - Auto-generate test
4. `<leader>GT` - Test specific function
5. `<leader>Gc` - Check coverage

---

## 🎨 **Formatting & Imports**

- **On Save**: Automatically formats with `gofumpt` and organizes imports
- **LSP**: Provides additional formatting and import suggestions

---

## 🔧 **Tools & Utilities**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>Gm` | `:GoMod` | Go mod tidy |
| `<leader>GM` | `:GoModInit` | Go mod init |
| `<leader>Gv` | `:GoVet` | Run go vet |
| `<leader>Gl` | `:GoLint` | Run golint |
| `<leader>Gd` | `:GoDoc` | Show documentation |

### **📦 Module Management**
```bash
# In terminal or use Neovim commands:
<leader>GM    # Initialize module
<leader>Gm    # Tidy dependencies
<leader>Gv    # Vet code
<leader>Gl    # Lint code
```

---

## ⚡ **Code Generation**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>Gs` | `:GoFillStruct` | Fill struct with zero values |
| `<leader>GS` | `:GoFillSwitch` | Fill switch statement |
| `<leader>Ge` | `:GoIfErr` | Add if err != nil block |
| `<leader>GE` | `:GoAddTest` | Generate test for function |

### **🎯 Code Generation Examples**

**Fill Struct** (`<leader>Gs`):
```go
type User struct {
    Name string
    Age  int
}

// Cursor on User{}, press <leader>Gs
user := User{
    Name: "",
    Age:  0,
}
```

**If Err** (`<leader>Ge`):
```go
// After function that returns error, press <leader>Ge
result, err := someFunction()
if err != nil {
    return err
}
```

---

## 🏷️ **Struct Tags & Interface**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>Gj` | `:GoAddTag` | Add struct tags (json, yaml, etc.) |
| `<leader>GJ` | `:GoRmTag` | Remove struct tags |
| `<leader>Go` | `:GoImpl` | Implement interface |

### **🏷️ Tag Management**
```go
type User struct {
    Name string
    Age  int
}

// Position cursor on struct, press <leader>Gj
type User struct {
    Name string `json:"name"`
    Age  int    `json:"age"`
}
```

---

## 🧭 **Navigation**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>Gn` | `:GoAlt` | Switch between file and test |
| `<leader>GN` | `:GoAltV` | Switch to test (vertical split) |

### **📁 File Navigation**
- `main.go` ↔ `main_test.go`
- `user.go` ↔ `user_test.go`
- Works both ways automatically!

---

## 🐛 **Debugging**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>dgt` | Debug Go test | Debug test under cursor |
| `<leader>dgl` | Debug last | Debug last test run |
| `<leader>dgr` | Debug restart | Restart debug session |

### **🔍 Debug Workflow**
1. Set breakpoint: `<leader>db`
2. Debug test: `<leader>dgt`
3. Step through: `<leader>di` (into), `<leader>dO` (over)
4. Inspect variables in DAP UI

---

## 📐 **LSP Features**

| Key | Command | Description |
|-----|---------|-------------|
| `gd` | Go to definition | Jump to definition |
| `gr` | References | Show all references |
| `K` | Hover docs | Show documentation |
| `<leader>ca` | Code actions | Available actions |
| `<leader>rn` | Rename | Rename symbol |

---

## 🎯 **Common Workflows**

### **🆕 New Go Project**
```bash
mkdir myapp && cd myapp
go mod init github.com/user/myapp
nvim main.go
# Write code, then <leader>Gr to run
```

### **🧪 TDD Workflow**
1. Write function signature
2. `<leader>GE` - Generate test
3. Write test cases
4. `<leader>GT` - Run test (should fail)
5. Implement function
6. `<leader>GT` - Run test (should pass)
7. `<leader>Gc` - Check coverage

### **🔧 Refactoring Workflow**
1. `<leader>Gv` - Vet code
2. `<leader>Gl` - Lint code
3. `<leader>rn` - Rename symbols
4. `<leader>ca` - Use code actions
5. `<leader>Gf` - Format code

### **🐛 Debug Workflow**
1. `<leader>db` - Set breakpoints
2. `<leader>dgt` - Debug test
3. Use DAP UI to inspect
4. `<leader>dgr` - Restart if needed

---

## 📚 **Additional Resources**

- **Go Documentation**: `<leader>Gd` on any symbol
- **LSP Hover**: `K` for quick docs
- **Go to Definition**: `gd`
- **Find References**: `gr`
- **Organize Imports**: Automatic on save
- **Error Checking**: Real-time with gopls

---

## 🎨 **Pro Tips**

💡 **Auto-save formatting**: Code auto-formats on save
💡 **Smart imports**: Unused imports removed automatically
💡 **Test navigation**: `<leader>Gn` quickly switches between code and tests
💡 **Error handling**: `<leader>Ge` quickly adds error checks
💡 **Struct completion**: `<leader>Gs` fills structs instantly
💡 **Interface implementation**: `<leader>Go` implements interfaces

Your Go development is now supercharged! 🚀
