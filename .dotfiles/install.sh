# install nix
curl -L https://nixos.org/nix/install | sh

# source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# install packages
nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.antibody \
	nixpkgs.git \
	nixpkgs.neovim \
	nixpkgs.tmux \
	nixpkgs.stow \
	nixpkgs.yarn \
	nixpkgs.fzf \
	nixpkgs.ripgrep \
	nixpkgs.zoxide \
	nixpkgs.exa \
	nixpkgs.fd \
	nixpkgs.gnupg \
	nixpkgs.silver-searcher \
	nixpkgs.bat \
	nixpkgs.warp \
	nixpkgs.vim \
	nixpkgs.direnv

# stow dotfiles
stow git
stow nvim
stow tmux
stow zsh
stow vim

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# bundle zsh plugins 
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# install neovim plugins
nvim --headless +PlugInstall +qall

# Use kitty terminal on MacOS
# [ `uname -s` = 'Darwin' ] && stow kitty
