configs
=======

My Bash/fish, nVim, Git configs.

# Firefox
- To enable the chrome settings for fixing tabstyle tree layout, place the chrome folder under AppData/Roaming/Mozilla/Firefox/<blah blah>.default-release
- Enable the toolkit.legacy stuff in about:config

# NeoVim
- Using NeoVim 0.7+
- Keeping copy with theme change to tokyonight in `nvim_config`
- For fresh install of NvChad:
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
    nvim +'hi NormalFloat guibg=#1e222a' +PackerSync

# tmux setup
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .