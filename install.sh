#!/bin/bash

# Installation script for vishal340/new_nvim Neovim configuration
# Supports macOS and Linux

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
			# Try different package managers
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

# Install LSP servers and tools
install_lsp_tools() {
	print_info "Installing LSP servers and development tools..."

	# Try to install Node.js if not present (needed for some LSPs)
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
		print_success "Node.js installed"
	fi

	# Try to install Python if not present (needed for DAP and some LSPs)
	if ! command -v python3 &>/dev/null; then
		print_info "Installing Python 3..."
		if [[ "$OS" == "macos" ]]; then
			brew install python3
		elif [[ "$OS" == "linux" ]]; then
			if command -v apt &>/dev/null; then
				sudo apt install -y python3 python3-pip
			elif command -v pacman &>/dev/null; then
				sudo pacman -S python python-pip
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y python3 python3-pip
			elif command -v yum &>/dev/null; then
				sudo yum install -y python3 python3-pip
			fi
		fi
		print_success "Python 3 installed"
	fi

	# Install Ripgrep (used by Telescope)
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
		print_success "Ripgrep installed"
	fi

	# Install FZF (for Telescope)
	if ! command -v fzf &>/dev/null; then
		print_info "Installing FZF..."
		if [[ "$OS" == "macos" ]]; then
			brew install fzf
		elif [[ "$OS" == "linux" ]]; then
			if command -v apt &>/dev/null; then
				sudo apt install -y fzf
			elif command -v pacman &>/dev/can/dev/null; then
				sudo pacman -S fzf
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y fzf
			elif command -v yum &>/dev/null; then
				sudo yum install -y fzf
			fi
		fi
		print_success "FZF installed"
	fi
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

# Main installation flow
main() {
	echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
	echo -e "${BLUE}║  vishal340/new_nvim Installation Script                     ║${NC}"
	echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
	echo ""

	detect_os
	print_info "Starting installation process..."
	echo ""

	install_neovim
	echo ""

	install_git
	echo ""

	install_lsp_tools
	echo ""

	clone_config
	echo ""

	initialize_lazy
	echo ""

	echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
	echo -e "${GREEN}║  Installation completed successfully!                      ║${NC}"
	echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
	echo ""
	print_success "Your Neovim configuration is ready to use!"
	print_info "Launch Neovim with: nvim"
	echo ""
	print_info "Configuration location: $HOME/.config/nvim"
	echo ""
}

# Run main function
main
