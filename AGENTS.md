# AGENTS.md - Development Guidelines

## Build/Test/Lint Commands
- `task deps` - Install Ansible Galaxy collections (run first)
- `task check` - Validate Ansible syntax
- `task dry-run` - Preview changes without applying
- `task pkg <domain>` - Install specific domain (base, development, gui)
- `task dot` - Setup conditional dotfiles symlinks
- `task clean` - Clean broken symlinks in home directory
- `ansible-playbook --syntax-check -i inventory/localhost.yml site.yml` - Syntax check single playbook

## Code Style Guidelines
- **YAML**: 2-space indentation, follow `.editorconfig` rules
- **Ansible**: Use `---` document separator, quote strings with spaces/special chars
- **File naming**: Use lowercase with hyphens (kebab-case) for YAML files
- **Variables**: Use snake_case for Ansible variables, prefix role vars with role name
- **Tasks**: Always include `name` field, use descriptive names starting with verb
- **Conditionals**: Use `when:` clause, prefer `ansible_os_family` over `ansible_distribution`
- **Loops**: Use `loop:` with `loop_control.loop_var` for clarity
- **Handlers**: Place in `handlers/main.yml`, use `notify:` to trigger
- **Error handling**: Use `failed_when:`, `ignore_errors:`, or `rescue:` blocks appropriately
- **Idempotency**: Ensure tasks can run multiple times safely using `creates:`, `state:`, etc.