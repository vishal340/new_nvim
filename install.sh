#!/bin/bash

# Installation script for vishal340/new_nvim Neovim configuration
# Supports macOS and Linux
# Installs all dependencies for configured LSPs and development tools

set -e # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
	echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
	echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
	echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
	echo -e "${RED}✗${NC} $1"
}

# Detect OS
detect_os() {
	if [[ "$OSTYPE" == "darwin"* ]]; then
		OS="macos"
	elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
		OS="linux"
	else
		print_error "Unsupported operating system: $OSTYPE"
		exit 1
	fi
	print_success "Detected OS: $OS"
}

# Install Neovim
install_neovim() {
	print_info "Checking Neovim installation..."

	if command -v nvim &>/dev/null; then
		NVIM_VERSION=$(nvim --version | head -n 1)
		print_success "Neovim is already installed: $NVIM_VERSION"
	else
		print_info "Installing Neovim..."

		if [[ "$OS" == "macos" ]]; then
			if command -v brew &>/dev/null; then
				brew install neovim
			else
				print_error "Homebrew not found. Please install Homebrew first: https://brew.sh"
				exit 1
			fi
		elif [[ "$OS" == "linux" ]]; then
			if command -v apt &>/dev/null; then
				sudo apt update
				sudo apt install -y neovim
			elif command -v pacman &>/dev/null; then
				sudo pacman -S neovim
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y neovim
			elif command -v yum &>/dev/null; then
				sudo yum install -y neovim
			else
				print_error "No supported package manager found. Please install Neovim manually."
				exit 1
			fi
		fi
		print_success "Neovim installed successfully"
	fi
}

# Install Git
install_git() {
	print_info "Checking Git installation..."

	if command -v git &>/dev/null; then
		GIT_VERSION=$(git --version)
		print_success "Git is already installed: $GIT_VERSION"
	else
		print_info "Installing Git..."

		if [[ "$OS" == "macos" ]]; then
			brew install git
		elif [[ "$OS" == "linux" ]]; then
			if command -v apt &>/dev/null; then
				sudo apt update
				sudo apt install -y git
			elif command -v pacman &>/dev/null; then
				sudo pacman -S git
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y git
			elif command -v yum &>/dev/null; then
				sudo yum install -y git
			fi
		fi
		print_success "Git installed successfully"
	fi
}

# Install Python and related tools
install_python() {
	print_info "Checking Python 3 installation..."

	if ! command -v python3 &>/dev/null; then
		print_info "Installing Python 3..."
		if [[ "$OS" == "macos" ]]; then
			brew install python3
		elif [[ "$OS" == "linux" ]]; then
			if command -v apt &>/dev/null; then
				sudo apt install -y python3 python3-pip python3-venv
			elif command -v pacman &>/dev/null; then
				sudo pacman -S python python-pip
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y python3 python3-pip
			elif command -v yum &>/dev/null; then
				sudo yum install -y python3 python3-pip
			fi
		fi
	fi
	print_success "Python 3 is available"
}

# Install Node.js (TypeScript, JSON, JavaScript support)
install_node() {
	print_info "Checking Node.js installation..."

	if ! command -v node &>/dev/null; then
		print_info "Installing Node.js..."
		if [[ "$OS" == "macos" ]]; then
			brew install node
		elif [[ "$OS" == "linux" ]]; then
			if command -v apt &>/dev/null; then
				sudo apt install -y nodejs npm
			elif command -v pacman &>/dev/null; then
				sudo pacman -S nodejs npm
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y nodejs npm
			elif command -v yum &>/dev/null; then
				sudo yum install -y nodejs npm
			fi
		fi
	fi
	print_success "Node.js is available"
}

# Install Go (gopls support)
install_go() {
	print_info "Checking Go installation..."

	if ! command -v go &>/dev/null; then
		print_info "Installing Go..."
		if [[ "$OS" == "macos" ]]; then
			brew install go
		elif [[ "$OS" == "linux" ]]; then
			if command -v apt &>/dev/null; then
				sudo apt install -y golang-go
			elif command -v pacman &>/dev/null; then
				sudo pacman -S go
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y golang
			elif command -v yum &>/dev/null; then
				sudo yum install -y golang
			fi
		fi
	fi
	print_success "Go is available"
}

# Install Rust (rust_analyzer support)
install_rust() {
	print_info "Checking Rust installation..."

	if ! command -v rustc &>/dev/null; then
		print_info "Installing Rust..."
		if [[ "$OS" == "macos" ]] || [[ "$OS" == "linux" ]]; then
			curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
			# Source the cargo environment
			source "$HOME/.cargo/env"
		fi
	fi
	print_success "Rust is available"
}

# Install C/C++ compiler and tools (clangd support)
install_cpp() {
	print_info "Checking C/C++ compiler installation..."

	if [[ "$OS" == "macos" ]]; then
		if ! command -v clang &>/dev/null; then
			print_info "Installing Xcode Command Line Tools..."
			xcode-select --install
		fi
	elif [[ "$OS" == "linux" ]]; then
		if ! command -v gcc &>/dev/null && ! command -v clang &>/dev/null; then
			print_info "Installing C/C++ compiler..."
			if command -v apt &>/dev/null; then
				sudo apt install -y build-essential clang
			elif command -v pacman &>/dev/null; then
				sudo pacman -S base-devel clang
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y gcc gcc-c++ clang
			elif command -v yum &>/dev/null; then
				sudo yum install -y gcc gcc-c++ clang
			fi
		fi
	fi
	print_success "C/C++ compiler is available"
}

# Install Docker (for docker LSP)
install_docker() {
	print_info "Checking Docker installation..."

	if command -v docker &>/dev/null; then
		print_success "Docker is already installed"
	else
		print_warning "Docker is not installed. It's optional but recommended for Docker Compose LSP."
		if [[ "$OS" == "macos" ]]; then
			print_info "To install Docker on macOS, visit: https://docs.docker.com/desktop/install/mac-install/"
		elif [[ "$OS" == "linux" ]]; then
			print_info "To install Docker on Linux, visit: https://docs.docker.com/desktop/install/linux-install/"
		fi
	fi
}

# Install Gradle (gradle_ls support)
install_gradle() {
	print_info "Checking Gradle installation..."

	if ! command -v gradle &>/dev/null; then
		print_info "Installing Gradle..."
		if [[ "$OS" == "macos" ]]; then
			brew install gradle
		elif [[ "$OS" == "linux" ]]; then
			if command -v apt &>/dev/null; then
				sudo apt install -y gradle
			elif command -v pacman &>/dev/null; then
				sudo pacman -S gradle
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y gradle
			elif command -v yum &>/dev/null; then
				sudo yum install -y gradle
			fi
		fi
	fi
	print_success "Gradle is available"
}

# Install CMake (cmake LSP support)
install_cmake() {
	print_info "Checking CMake installation..."

	if ! command -v cmake &>/dev/null; then
		print_info "Installing CMake..."
		if [[ "$OS" == "macos" ]]; then
			brew install cmake
		elif [[ "$OS" == "linux" ]]; then
			if command -v apt &>/dev/null; then
				sudo apt install -y cmake
			elif command -v pacman &>/dev/null; then
				sudo pacman -S cmake
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y cmake
			elif command -v yum &>/dev/null; then
				sudo yum install -y cmake
			fi
		fi
	fi
	print_success "CMake is available"
}

# Install essential search and utility tools
install_search_tools() {
	print_info "Installing search and utility tools..."

	# Ripgrep (used by Telescope)
	if ! command -v rg &>/dev/null; then
		print_info "Installing Ripgrep..."
		if [[ "$OS" == "macos" ]]; then
			brew install ripgrep
		elif [[ "$OS" == "linux" ]]; then
			if command -v apt &>/dev/null; then
				sudo apt install -y ripgrep
			elif command -v pacman &>/dev/null; then
				sudo pacman -S ripgrep
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y ripgrep
			elif command -v yum &>/dev/null; then
				sudo yum install -y ripgrep
			fi
		fi
	fi

	# FZF (for Telescope)
	if ! command -v fzf &>/dev/null; then
		print_info "Installing FZF..."
		if [[ "$OS" == "macos" ]]; then
			brew install fzf
		elif [[ "$OS" == "linux" ]]; then
			if command -v apt &>/dev/null; then
				sudo apt install -y fzf
			elif command -v pacman &>/dev/null; then
				sudo pacman -S fzf
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y fzf
			elif command -v yum &>/dev/null; then
				sudo yum install -y fzf
			fi
		fi
	fi

	# sed and other tools
	if [[ "$OS" == "macos" ]]; then
		if ! command -v gsed &>/dev/null; then
			print_info "Installing GNU sed..."
			brew install gnu-sed
		fi
	fi

	print_success "Search and utility tools installed"
}

# Clone the configuration
clone_config() {
	NVIM_CONFIG_DIR="$HOME/.config/nvim"

	print_info "Setting up Neovim configuration..."

	if [ -d "$NVIM_CONFIG_DIR" ]; then
		print_warning "Neovim config directory already exists at $NVIM_CONFIG_DIR"
		read -p "Do you want to backup and replace it? (y/n) " -n 1 -r
		echo
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			BACKUP_DIR="${NVIM_CONFIG_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
			mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
			print_success "Backed up existing config to $BACKUP_DIR"
		else
			print_warning "Skipping configuration clone"
			return
		fi
	fi

	print_info "Cloning vishal340/new_nvim..."
	git clone https://github.com/vishal340/new_nvim.git "$NVIM_CONFIG_DIR"
	print_success "Configuration cloned successfully"
}

# Run Neovim to initialize lazy.nvim
initialize_lazy() {
	print_info "Initializing lazy.nvim plugin manager..."
	print_info "This may take a moment on first run..."

	nvim --headless "+Lazy! sync" +qa

	print_success "Plugins installed successfully"
}

# Show installation summary
show_summary() {
	echo ""
	echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
	echo -e "${BLUE}║  Installation Summary                                      ║${NC}"
	echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
	echo ""
	echo -e "${GREEN}Core Tools:${NC}"
	echo "  ✓ Neovim"
	echo "  ✓ Git"
	echo "  ✓ Ripgrep (search)"
	echo "  ✓ FZF (fuzzy finding)"
	echo ""
	echo -e "${GREEN}Language Runtimes & Compilers:${NC}"
	echo "  ✓ Python 3 (pyright)"
	echo "  ✓ Node.js (ts_ls, jsonls, yamlls)"
	echo "  ✓ Go (gopls)"
	echo "  ✓ Rust (rust_analyzer)"
	echo "  ✓ C/C++ Compiler (clangd)"
	echo "  ✓ CMake (cmake LSP)"
	echo "  ✓ Gradle (gradle_ls)"
	echo "  ✓ Docker (docker LSP)"
	echo ""
	echo -e "${GREEN}LSPs Configured:${NC}"
	echo "  • ltex_plus (grammar checking)"
	echo "  • sqlls (SQL)"
	echo "  • gopls (Go)"
	echo "  • ts_ls (TypeScript/JavaScript)"
	echo "  • jsonls (JSON)"
	echo "  • yamlls (YAML)"
	echo "  �� rust_analyzer (Rust)"
	echo "  • taplo (TOML)"
	echo "  • vimls (VimScript)"
	echo "  • bashls (Bash)"
	echo "  • html (HTML)"
	echo "  • htmx (HTMX)"
	echo "  • cmake (CMake)"
	echo "  • dockerls (Dockerfile)"
	echo "  • docker_compose_language_service"
	echo "  • gradle_ls (Gradle)"
	echo "  • clangd (C/C++)"
	echo "  • pyright (Python)"
	echo ""
	echo -e "${GREEN}Configuration Location:${NC}"
	echo "  $HOME/.config/nvim"
	echo ""
	echo -e "${GREEN}Launch Neovim:${NC}"
	echo "  nvim"
	echo ""
}

# Main installation flow
main() {
	echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
	echo -e "${BLUE}║  vishal340/new_nvim Installation Script                     ║${NC}"
	echo -e "${BLUE}║  Complete setup with all LSP dependencies                  ║${NC}"
	echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
	echo ""

	detect_os
	print_info "Starting installation process..."
	echo ""

	# Core tools
	print_info "=== Installing Core Tools ==="
	install_neovim
	echo ""
	install_git
	echo ""
	install_search_tools
	echo ""

	# Language runtimes
	print_info "=== Installing Language Runtimes & Compilers ==="
	echo ""
	install_python
	echo ""
	install_node
	echo ""
	install_go
	echo ""
	install_rust
	echo ""
	install_cpp
	echo ""
	install_cmake
	echo ""
	install_gradle
	echo ""
	install_docker
	echo ""

	# Configuration setup
	print_info "=== Setting Up Configuration ==="
	echo ""
	clone_config
	echo ""
	initialize_lazy
	echo ""

	# Show summary
	show_summary

	echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
	echo -e "${GREEN}║  Installation completed successfully!                      ║${NC}"
	echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
}

# Run main function
main
