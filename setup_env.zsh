sudo apt install -y \
  aptitude \
  build-essential \
  clang-format \
  hub \
  neovim \
  python-is-python3 \
  python3 \
  python3-pip \
  ripgrep \
  shfmt \
  tmux

# Install vim-plug
if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Link configuration files
mkdir -p ~/.config/nvim
ln -sf $(pwd)/vimrc ~/.config/nvim/init.vim
ln -sf $(pwd)/vim_tasks.ini ~/.config/nvim/tasks.ini
mkdir -p ~/.config/coc/ultisnips/
ln -sf $(pwd)/cpp.snippets ~/.config/coc/ultisnips/cpp.snippets
ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/gitignore ~/.gitignore
ln -sf $(pwd)/tmux.conf ~/.tmux.conf
ln -sf $(pwd)/zshrc ~/.zshrc
source ~/.zshrc

# Install nvm and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.zshrc
nvm install node

# Install python libs
python3 -m pip install black jupyterlab numpy pandas matplotlib

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install vim plugins
vim -c "PlugInstall" -c "qall"
vim -c "CocInstall coc-clangd" -c "CocInstall coc-pyright" -c "CocInstall coc-rust-analyzer" -c "CocInstall coc-snippets"
vim -c "set filetype=cpp" -c "CocCommand clangd.install"
