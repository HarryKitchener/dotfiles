 1 # Dmitry Demenchuk does dotfiles
 2
 3 The single dot that has it all.
 4
 5 Clone the repository into ~/dotfiles: git clone https://github.com/mrded/dotfiles.git ~/dotfiles
 6
 7
 8 ## IntelliJ IDEA Vim.
 9
10 ln -s ~/dotfiles/.ideavimrc ~/.ideavimrc
11
12 ## Vim
13 - I use vim 8.0 compiled like following: brew install vim --override-system-vim --with-cscope --with-lua
14 - Replace ~/.vimrc: ln -s ~/dotfiles/.vimrc ~/.vimrc
15 - Install vim-plug then run :PlugInstall
16
17 ## NeoVim
18 - Replace ~/.config/nvim/init.vim: ln -s ~/dotfiles/.vimrc ~/.config/nvim/init.vim
19 - Install vim-plug then run :PlugInstall
20 - Requires Ruby support: gem install neovim
21 - Requires Python (2.6+ or 3.3+) support: pip2 install --user neovim
22
23 ## Troubleshooting
24
25 neovim sometimes may not install pluggins propperly. Try to run following:
26
27   ⦙ :UpdateRemotePlugins
28
29
30 ## dyng/ctrlsf.vim
31
32 - brew install ack                                                                                                                                                                                                                                    markdown  111 words  codeowners  ☲ [8]trailing
