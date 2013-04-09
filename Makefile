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


all: install_fonts install_bash install_vim install_git_home install_i3 \
	 install_irssi install_python install_tmux
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

clean_bash:
	rm -Rf ~/.bashrc

install_vim: clean_vim
	ln -sf `pwd`/vimrc ~/.vimrc
	ln -sf `pwd`/vim   ~/.vim

clean_vim:
	rm -Rf ~/.vimrc
	rm -Rf ~/.vim

install_git_home: clean_git_home
	ln -sf `pwd`/gitconfig_home ~/.gitconfig

clean_git_home:
	rm -Rf ~/.gitconfig

install_i3: clean_i3
	ln -sf `pwd`/Xdefaults ~/.Xdefaults
	ln -sf `pwd`/i3 ~/.i3

clean_i3:
	rm -Rf ~/.Xdefaults
	rm -Rf ~/.i3

install_irssi: clean_irssi
	@echo ""
	@echo "Make sure to specific FREENODEPASS=somepass argument."
	@echo ""
	cp `pwd`/irssi ~/.irssi -R;
	sed -i 's/__irssipassword__/$(FREENODEPASS)/g' ~/.irssi/config

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
