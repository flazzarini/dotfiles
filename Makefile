#
# Makefile for dotfiles
#
# You can use this Makefile to install individual dotfiles or install all of
# them at once. Each makefile rule first cleans the exisiting dotfile by
# removing it and replacing it with a symlink to the specific file in
# ~/dotfiles.
#
# !!! Make sure you backup your stuff first !!!
#
# make install_irssi expects a FREENODEPASS to replace __irssipassword__ in
# the config. So you should use make install_irssi FREENODEPASS=somepass or
# make all FREENODEPASS=somepass
#
SHELL=/bin/bash

help:
	@echo 'Makefile for dotfiles                                                  '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make all                         install everything                 '
	@echo '   make install_fonts               install custom fonts               '
	@echo '   make install_bash                install bashrc                     '
	@echo '   make install_vim                 install vim files                  '
	@echo '   make install_git_home            install git home files             '
	@echo '   make install_git_work            install git work files             '
	@echo '   make install_taskwarrior         installs taskrc                    '
	@echo '   make install_i3                  install i3 files                   '
	@echo '   make install_bspwm               install bspwm files                '
	@echo '   make install_python              install ipython files              '
	@echo '   make install_irssi               install irssi --irssipassword=X    '
	@echo '   make install_tmux                install tmux conf files            '
	@echo '   make install_sqlite              install sqlite conf files          '
	@echo '   make install_conky               installs conky config              '
	@echo '   make install_conky_work          installs conky work config         '
	@echo '   make install_psql                installs psqlrc                    '
	@echo '   make install_roxterm             installs roxterm files             '
	@echo '   make install_beets               installs beets files               '
	@echo '   make install_winbox              downloads and installs winbox      '
	@echo '                                                                       '
	@echo 'All install commands are also available as clean commands to remove    '
	@echo 'installed files                                                        '
	@echo '                                                                       '


all: install_fonts install_bash install_vim install_git_home install_i3 \
	 install_irssi install_python install_tmux install_psql
	@echo ""
	@echo "dotfiles - Making yourself at home"
	@echo "=================================="
	@echo ""
	@echo "All done."

install_fonts: clean_fonts
	ln -sf `pwd`/fonts ~/.fonts

clean_fonts:
	rm -Rf ~/.fonts

install_bash: clean_bash install_bat
	ln -sf `pwd`/bashrc ~/.bashrc
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/bash_profile ~/.bash_profile
	ln -sf `pwd`/inputrc ~/.inputrc
	ln -sf `pwd`/bin ~/bin
	ln -sf `pwd`/inputrc ~/.inputrc
	[ -d ~/.config ] || mkdir ~/.config
	ln -sf `pwd`/htop ~/.config/
	[ -d terminal-color-theme ] || git clone --recursive https://github.com/sona-tar/terminal-color-theme.git
	[ -d fzf ] || git clone --depth 1 https://github.com/junegunn/fzf.git `pwd`/fzf
	cd fzf && git pull && ./install --bin
	ln -sf `pwd`/fzf/bin/fzf `pwd`/bin

clean_bash:
	rm -Rf ~/.inputrc
	rm -Rf ~/.bashrc
	rm -Rf ~/.bash_aliases
	rm -Rf ~/.bash_profile
	rm -Rf ~/bin
	rm -Rf ~/.inputrc
	rm -Rf ~/.config/htop

install_vim: clean_vim
	@echo Installing Vim-Plug
	curl -fLo `pwd`/vim/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@echo Place vim config files
	ln -sf `pwd`/vimrc ~/.vimrc
	ln -sf `pwd`/vim   ~/.vim

clean_vim:
	rm -Rf ~/.vimrc
	rm -Rf ~/.vim
	rm -Rf ~/.vimdb

install_nvim: clean_nvim
	@echo Installing vundle for neovim
	git clone https://github.com/gmarik/Vundle.vim.git `pwd`/nvim/bundle/Vundle.vim
	ln -sf `pwd`/nvimrc ~/.nvimrc
	ln -sf `pwd`/nvim   ~/.nvim

clean_nvim:
	rm -Rf ~/.nvimrc
	rm -Rf ~/.nvim

install_git_home: clean_git_home
	ln -sf `pwd`/gitconfig_home ~/.gitconfig

clean_git_home:
	rm -Rf ~/.gitconfig

install_git_work: clean_git_work
	ln -sf `pwd`/gitconfig_work ~/.gitconfig

clean_git_work:
	rm -Rf ~/.gitconfig

install_i3: clean_i3
	ln -sf `pwd`/xinitrc ~/.xinitrc
	ln -sf `pwd`/Xresources ~/.Xresources
	ln -sf `pwd`/xession ~/.xsession
	ln -sf `pwd`/i3 ~/.i3
	ln -sf `pwd`/compton.conf ~/.config/compton.conf

clean_i3:
	rm -Rf ~/.xinitrc
	rm -Rf ~/.xsession
	rm -Rf ~/.Xdefaults
	rm -Rf ~/.Xresources
	rm -Rf ~/.i3
	rm -Rf ~/.config/polybar
	rm -Rf ~/.config/compton.conf

install_bspwm: clean_bspwm
	ln -sf `pwd`/xinitrc ~/.xinitrc
	ln -sf `pwd`/Xresources ~/.Xresources
	ln -sf `pwd`/xession ~/.xsession
	ln -sf `pwd`/bspwm ~/.config/bspwm
	ln -sf `pwd`/polybar ~/.config/polybar
	ln -sf `pwd`/sxhkd ~/.config/sxhkd
	ln -sf `pwd`/compton.conf ~/.config/compton.conf

clean_bspwm:
	rm -Rf ~/.xinitrc
	rm -Rf ~/.xsession
	rm -Rf ~/.Xdefaults
	rm -Rf ~/.Xresources
	rm -Rf ~/.config/bspwm
	rm -Rf ~/.config/polybar
	rm -Rf ~/.config/sxhkd
	rm -Rf ~/.config/compton.conf

install_irssi:
ifneq "$(IRSSIUSER)" ""
	cp `pwd`/irssi ~/.irssi -R
	sed -i 's/__irssiuser__/$(IRSSIUSER)/g' ~/.irssi/config
	sed -i 's/__irssipass__/$(IRSSIPASS)/g' ~/.irssi/config
else
	@echo ""
	@echo "Make sure to specific IRSSIUSER=somevalue environment variable."
	@echo ""
endif

clean_irssi:
	rm -Rf ~/.irssi

install_python: clean_python
	ln -sf `pwd`/pylintrc ~/.pylintrc
	ln -sf `pwd`/ipython ~/.config/ipython

clean_python:
	rm -Rf ~/.pylintrc
	rm -Rf ~/.config/ipython

install_tmux: clean_tmux
	[ -d ~/.tmux ] || mkdir ~/.tmux
	[ -d ~/.tmux/tmux-power ] || git clone https://github.com/wfxr/tmux-power.git ~/.tmux/tmux-power
	ln -sf `pwd`/tmux.conf ~/.tmux.conf
	[ -d ~/.ssh ] || mkdir ~/.ssh
	ln -sf `pwd`/sshrc ~/.ssh/rc
	tic `pwd`/tmux18-256color.ti

clean_tmux:
	rm -Rf ~/.tmux.conf
	rm -Rf ~/.tmux-powerlinerc
	rm -Rf ~/.bin/tmux-powerline/themes/my_theme.sh
	rm -Rf ~/.bin/tmux-powerline
	rm -Rf ~/.ssh/rc

install_sqlite: clean_sqlite
	ln -sf `pwd`/sqliterc ~/.sqliterc

clean_sqlite:
	rm -Rf ~/.sqliterc

install_conky:
	ln -sf `pwd`/conky/conky.conf ~/.conkyrc

clean_conky:
	rm -Rf ~/.taskrc

install_taskwarrior:
	ln -sf `pwd`/taskrc ~/.taskrc

clean_taskwarrior:
	rm -Rf ~/.conkyrc

install_conky_work:
	ln -sf `pwd`/conky/conky_work.conf ~/.conkyrc

clean_conky_work:
	rm -Rf ~/.conkyrc

install_psql:
	ln -sf `pwd`/psqlrc ~/.psqlrc

clean_psql:
	rm -Rf ~/.psqlrc

install_roxterm:
	ln -sf `pwd`/roxterm ~/.config/roxterm.sourceforge.net

clean_roxterm:
	rm -Rf ~/.config/roxterm.sourceforge.net

install_beets:
	[ -d ~/.config/beets ] || mkdir ~/.config/beets
	ln -sf `pwd`/beets/config.yaml ~/.config/beets/config.yaml
	ln -sf `pwd`/beets/whitelist.txt ~/.config/beets/whitelist.txt

clean_beets:
	rm -Rf ~/.config/beets/config.yaml
	rm -Rf ~/.config/beets/whitelist.txt

install_winbox: clean_winbox
	@echo 'Installing Winbox 3.27 to /opt/winbox'
	[ -d /opt/winbox ] || sudo install -d -o `whoami` /opt/winbox
	cd /opt/winbox && wget -O winbox.exe https://mt.lv/winbox64

clean_winbox:
	@echo 'Removing Winbox from /opt/winbox/winbox.exe'
	if [ -f /opt/winbox/winbox.exe ]; then rm /opt/winbox/winbox.exe; fi

install_bat:
	@echo 'Install bat (cat on steroids)'
	installers/install_bat.sh
