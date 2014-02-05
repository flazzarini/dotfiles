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
	@echo '   make install_vim                 installs vim files                 '
	@echo '   make install_git_home            install git home files             '
	@echo '   make install_git_work            install git work files             '
	@echo '   make install_i3                  install i3 files                   '
	@echo '   make install_python              install ipython files              '
	@echo '   make install_irssi               installs irssi --irssipassword=X   '
	@echo '   make install_tmux                install tmux conf files            '
	@echo '   make install_sqlite              install sqlite conf files          '
	@echo '   make install_conky               installs conky config              '
	@echo '   make install_conky_work          installs conky work config         '
	@echo '   make install_psql                installs psqlrc                    '
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
	ln -sf `pwd`/htop ~/.config/htop

clean_bash:
	rm -Rf ~/.bashrc

install_vim: clean_vim
	@echo Installing vundle for vim
	git clone https://github.com/gmarik/vundle.git `pwd`/vim/bundle/vundle
	ln -sf `pwd`/vimrc ~/.vimrc
	ln -sf `pwd`/vim   ~/.vim

clean_vim:
	rm -Rf ~/.vimrc
	rm -Rf ~/.vim

install_git_home: clean_git_home
	ln -sf `pwd`/gitconfig_home ~/.gitconfig

clean_git_home:
	rm -Rf ~/.gitconfig

install_git_work: clean_git_work
	ln -sf `pwd`/gitconfig_work ~/.gitconfig

clean_git_work:
	rm -Rf ~/.gitconfig

install_i3: clean_i3
	ln -sf `pwd`/Xdefaults ~/.Xdefaults
	ln -sf `pwd`/i3 ~/.i3

clean_i3:
	rm -Rf ~/.Xdefaults
	rm -Rf ~/.i3

install_irssi:
ifneq "$(FREENODEPASS)" ""
	cp `pwd`/irssi ~/.irssi -R
	sed -i 's/__irssipassword__/$(FREENODEPASS)/g' ~/.irssi/config
else
	@echo ""
	@echo "Make sure to specific FREENODEPASS=somepass argument."
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

install_conky_work:
	ln -sf `pwd`/conky/conky_work.conf ~/.conkyrc

install_psql:
	ln -sf `pwd`/psqlrc ~/.psqlrc
