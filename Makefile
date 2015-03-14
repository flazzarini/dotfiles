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
	@echo '   make install_i3                  install i3 files                   '
	@echo '   make install_python              install ipython files              '
	@echo '   make install_irssi               install irssi --irssipassword=X    '
	@echo '   make install_tmux                install tmux conf files            '
	@echo '   make install_sqlite              install sqlite conf files          '
	@echo '   make install_conky               installs conky config              '
	@echo '   make install_conky_work          installs conky work config         '
	@echo '   make install_psql                installs psqlrc                    '
	@echo '   make install_roxterm             installs roxterm files             '
	@echo '   make install_beets               installs beets files               '
	@echo '   make install_urxvt               compile urxvt with apt-get         '
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

install_bash: clean_bash
	ln -sf `pwd`/bashrc ~/.bashrc
	ln -sf `pwd`/bash_profile ~/.bash_profile
	ln -sf `pwd`/htop ~/.config/htop

clean_bash:
	rm -Rf ~/.bashrc
	rm -Rf ~/.bash_profile

install_vim: clean_vim
	@echo Installing vundle for vim
	git clone https://github.com/gmarik/vundle.git `pwd`/vim/bundle/vundle
	ln -sf `pwd`/vimrc ~/.vimrc
	ln -sf `pwd`/vim   ~/.vim
	ln -sf `pwd`/vimdb ~/.vimdb

clean_vim:
	rm -Rf ~/.vimrc
	rm -Rf ~/.vim
	rm -Rf ~/.vimdb

install_git_home: clean_git_home
	ln -sf `pwd`/gitconfig_home ~/.gitconfig

clean_git_home:
	rm -Rf ~/.gitconfig

install_git_work: clean_git_work
	ln -sf `pwd`/gitconfig_work ~/.gitconfig

clean_git_work:
	rm -Rf ~/.gitconfig

install_i3: clean_i3
	ln -sf `pwd`/Xresources ~/.Xresources
	ln -sf `pwd`/xession ~/.xsession
	ln -sf `pwd`/i3 ~/.i3

clean_i3:
	rm -Rf ~/.Xdefaults
	rm -Rf ~/.i3

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
	ln -sf `pwd`/tmux.conf ~/.tmux.conf

clean_tmux:
	rm -Rf ~/.tmux.conf


install_sqlite: clean_sqlite
	ln -sf `pwd`/sqliterc ~/.sqliterc

clean_sqlite:
	rm -Rf ~/.sqliterc

install_conky:
	ln -sf `pwd`/conky/conky.conf ~/.conkyrc

clean_conky:
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

install_urxvt:
	cd `mktemp -d /tmp/rxvt.XXXXXX`
	apt-get source rxvt-unicode
	sudo apt-get build-dep rxvt-unicode
	cd rxvt-unicode-*/
	perl -pi -e 's/--enable-iso14755/--disable-iso14755/g' debian/rules
	dch -n 'ISO 14755/Keycap mode SUCKS!!!'
	fakeroot debian/rules binary
	sudo dpkg -i ../rxvt-unicode-lite*deb
