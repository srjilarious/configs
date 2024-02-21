FROM archlinux:latest

RUN pacman -Syu --noconfirm neovim git wget unzip fish which fd ripgrep bat

RUN chsh -s /usr/bin/fish
RUN curl https://raw.githubusercontent.com/tristanisham/zvm/master/install.sh | bash
RUN /root/.zvm/self/zvm i -D=zls master
# RUN /usr/bin/fish -c 'fish_add_path -Up /root/.zvm/bin'
# RUN /usr/bin/fish -c 'fish_add_path -Up /root/.zvm/self'
