# ⚡ Zig Development Cheatsheet

## 📋 **Quick Reference**

### **🎯 Key Prefix: `<leader>z*`**
All Zig commands use lowercase `z` for Zig development.

---

## 🏃 **Execution & Building**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>zr` | `:ZigRun` | Run current Zig file |
| `<leader>zt` | `:ZigTest` | Run Zig tests |
| `<leader>zb` | `:ZigBuild` | Build Zig project |
| `<leader>zf` | `:ZigFmt` | Format Zig code |
| `<leader>zc` | `:ZigCheck` | Check Zig syntax |
| `<leader>zi` | `:ZigInit` | Initialize Zig project |

### **💡 Quick Start**
```bash
# Create new Zig project
mkdir my-zig-app && cd my-zig-app
zig init-exe
nvim src/main.zig

# Inside Neovim: <leader>zr to run instantly!
```

---

## ⚡ **Core Zig Commands**

### **🚀 Execution**
```bash
<leader>zr    # zig run src/main.zig
<leader>zb    # zig build
<leader>zt    # zig test src/main.zig
```

### **🔧 Development Tools**
```bash
<leader>zf    # zig fmt (format code)
<leader>zc    # zig check (syntax check)
<leader>zi    # zig init-exe (new project)
```

---

## 📁 **Project Structure**

### **🎯 Standard Zig Project**
```
my-zig-project/
├── build.zig          # Build configuration
├── src/
│   ├── main.zig       # Main entry point
│   ├── lib.zig        # Library code
│   └── tests.zig      # Test files
└── zig-out/           # Build output (auto-generated)
    ├── bin/
    └── lib/
```

### **📝 build.zig Example**
```zig
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "my-app",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);
}
```

---

## 🔍 **LSP Features (ZLS)**

| Key | Command | Description |
|-----|---------|-------------|
| `gd` | Go to definition | Jump to definition |
| `gr` | References | Show all references |
| `K` | Hover docs | Show documentation |
| `<leader>ca` | Code actions | Available actions |
| `<leader>rn` | Rename | Rename symbol |

### **⚙️ ZLS Configuration**
The Zig Language Server provides:
- **Auto-completion**: Smart completions
- **Error diagnostics**: Real-time error checking
- **Go to definition**: Navigate code easily
- **Hover documentation**: Built-in docs
- **Formatting**: Integrated with `zig fmt`

---

## 🧪 **Testing in Zig**

### **📝 Test Structure**
```zig
const std = @import("std");
const testing = std.testing;

// Function to test
fn add(a: i32, b: i32) i32 {
    return a + b;
}

// Test cases
test "basic addition" {
    try testing.expect(add(2, 3) == 5);
}

test "addition with negative numbers" {
    try testing.expect(add(-1, 1) == 0);
}

test "addition overflow" {
    const result = add(std.math.maxInt(i32), 1);
    try testing.expect(result == std.math.minInt(i32));
}
```

### **🧪 Running Tests**
```bash
<leader>zt              # Run all tests in current file
zig test src/main.zig   # Command line equivalent
zig test src/           # Test entire source directory
```

---

## 🎨 **Code Formatting**

### **⚡ Auto-Formatting**
- **On Save**: Automatically formats with `zig fmt`
- **Manual**: `<leader>zf` to format current file
- **Style**: Enforces Zig's official style guide

### **📏 Format Configuration**
Zig formatting is opinionated and consistent:
- **Indentation**: 4 spaces
- **Line length**: 100 characters (configurable)
- **Brace style**: Consistent Zig style
- **No configuration needed**: Just works!

---

## 🛠️ **Build System**

### **⚚ Build Commands**
```bash
<leader>zb              # zig build
zig build run           # Build and run
zig build test          # Build and test
zig build install       # Install executable
```

### **🎯 Build Modes**
```bash
zig build -Doptimize=Debug      # Debug build (default)
zig build -Doptimize=ReleaseFast # Fast release
zig build -Doptimize=ReleaseSmall # Small release
zig build -Doptimize=ReleaseSafe  # Safe release
```

---

## 🎯 **Common Workflows**

### **🆕 New Zig Project**
```bash
# Initialize executable project
mkdir my-zig-app && cd my-zig-app
<leader>zi  # or: zig init-exe
nvim src/main.zig

# Write code, then <leader>zr to run
```

### **🔄 Development Cycle**
1. Write code in `src/main.zig`
2. `<leader>zc` - Check syntax
3. `<leader>zf` - Format code
4. `<leader>zt` - Run tests
5. `<leader>zr` - Run program
6. `<leader>zb` - Build for distribution

### **🧪 TDD Workflow**
1. Write test in your `.zig` file
2. `<leader>zt` - Run test (should fail)
3. Write minimal code to pass
4. `<leader>zt` - Run test (should pass)
5. `<leader>zf` - Format code
6. Refactor and repeat

---

## 📖 **Zig Language Essentials**

### **🔧 Basic Syntax**
```zig
const std = @import("std");

// Variables
const constant_value = 42;
var mutable_value: i32 = 10;

// Functions
fn greet(name: []const u8) void {
    std.debug.print("Hello, {s}!\n", .{name});
}

// Main function
pub fn main() void {
    greet("World");
}
```

### **⚡ Memory Management**
```zig
const std = @import("std");
const ArrayList = std.ArrayList;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var list = ArrayList(i32).init(allocator);
    defer list.deinit();

    try list.append(42);
    std.debug.print("Value: {}\n", .{list.items[0]});
}
```

### **🔍 Error Handling**
```zig
const MyError = error{
    InvalidInput,
    OutOfMemory,
};

fn parseNumber(input: []const u8) MyError!i32 {
    if (input.len == 0) return MyError.InvalidInput;
    // ... parsing logic
    return 42;
}

pub fn main() void {
    const result = parseNumber("123") catch |err| {
        std.debug.print("Error: {}\n", .{err});
        return;
    };
    std.debug.print("Result: {}\n", .{result});
}
```

---

## 🐛 **Debugging**

### **🔍 Debug Prints**
```zig
const std = @import("std");

pub fn main() void {
    const value = 42;
    std.debug.print("Debug: value = {}\n", .{value});
}
```

### **🔧 Debug Build**
```bash
<leader>zb              # Debug build (default)
zig build -Doptimize=Debug  # Explicit debug build
```

### **🛠️ Using Debuggers**
```bash
# Build with debug info
zig build -Doptimize=Debug

# Use with gdb/lldb
gdb zig-out/bin/my-app
lldb zig-out/bin/my-app
```

---

## 📐 **LSP Integration**

### **🔧 ZLS Features**
- **Smart completions**: Context-aware suggestions
- **Error diagnostics**: Real-time error checking
- **Goto definition**: Navigate easily
- **Find references**: See all usages
- **Hover docs**: Built-in documentation
- **Rename symbol**: Safe refactoring

### **⚡ Performance**
ZLS is built in Zig and is extremely fast:
- **Fast startup**: Quick initialization
- **Low memory**: Efficient memory usage
- **Real-time**: Instant feedback

---

## 🎨 **Pro Tips**

💡 **Zig fmt is opinionated**: No configuration needed, just works
💡 **Compile-time evaluation**: Use `comptime` for powerful metaprogramming
💡 **No hidden allocations**: Memory usage is always explicit
💡 **Cross-compilation**: Easily target different platforms
💡 **C interop**: Seamlessly call C libraries
💡 **Zero-cost abstractions**: Performance without overhead
💡 **Safety**: Catches bugs at compile time

### **🔥 Speed Tips**
- Use `<leader>zc` to quickly check syntax
- Use `<leader>zt` for rapid test feedback
- Use `<leader>zf` to maintain consistent style
- Use `<leader>zr` for immediate execution feedback

### **🎯 Zig Philosophy**
- **Only one obvious way**: Clear, readable code
- **Incremental improvements**: Easy to understand and modify
- **Robust**: Handle edge cases explicitly
- **Fast**: Compile-time optimizations
- **Portable**: Works everywhere

Your Zig development is now supercharged with modern tooling! ⚡🚀
