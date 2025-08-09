# Development Aliases

A collection of useful aliases to streamline development workflows and make life easier.

## 🚀 Quick Start

```bash
# Install the aliases
make install

# Restart your terminal or run:
source ~/.zshrc  # (or ~/.bashrc for bash users)
```

## 📋 Git Workflow Aliases

#### First commit to a new branch

```bash
ship {type} {ticket} {message}
```

**Examples:**

```bash
ship feat ENG-1234 "add user authentication"
ship fix ENG-5678 "resolve login bug"
ship docs ENG-9999 "update API documentation"
```

**What it does:**

- Creates branch: `{type}/{ticket}` (e.g., `feat/ENG-1234`)
- Adds all changes: `git add .`
- Commits: `git commit -m "{message}"`
- Pushes: `git push -u origin {branch}`

#### Subsequent commits on the same branch

```bash
commit {message}
```

**Examples:**

```bash
commit "fix validation logic"
commit "add error handling"
commit "update tests"
```

**What it does:**

- Adds all changes: `git add .`
- Commits: `git commit -m "{message}"`
- Pushes: `git push`

## 📖 Help

Get detailed help for any command:

```bash
ship --help     # or ship -h
commit --help   # or commit -h
make help       # Installation help
```

#### Conventional Commit Types

- `feat` - A new feature
- `fix` - A bug fix
- `docs` - Documentation changes
- `style` - Code style changes (formatting, etc.)
- `refactor` - Code refactoring
- `test` - Adding or updating tests
- `chore` - Maintenance tasks
- `perf` - Performance improvements
- `ci` - CI/CD changes
- `build` - Build system changes

#### Typical Git Workflow

```bash
# 1. Start new feature
ship feat ENG-1234 "implement user registration"

# 2. Continue working on the same branch
commit "add input validation"
commit "handle edge cases"
commit "update documentation"

# 3. Create pull request and merge
# 4. Switch back to main and start next feature
git checkout main
ship fix ENG-5678 "resolve authentication issue"
```

## 🛠️ Installation Details

The installer will:

- Detect your shell (zsh/bash)
- Add aliases to your shell configuration file
- Make the scripts executable
- Create backups of existing configurations

The installation is idempotent - you can run `make install` multiple times safely.

## 📁 File Structure

```
aliases/
├── git/
│   ├── ship.sh    # First commit + branch creation
│   └── commit.sh  # Subsequent commits
├── install.sh     # Installation script
├── Makefile       # Make targets
└── README.md      # This file
```
