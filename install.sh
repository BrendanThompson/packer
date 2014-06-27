#!/bin/sh

# Installer for Packer

if [[ -t 1 && ! $COLOR = "NO" ]]; then
  COLOR1='\e[1;39m'
  COLOR2='\e[1;32m'
  COLOR3='\e[1;35m'
  COLOR4='\e[1;36m'
  COLOR5='\e[1;34m'
  COLOR6='\e[1;33m'
  COLOR7='\e[1;31m'
  ENDCOLOR='\e[0m' 
  S='\\'
fi


runasroot() {
  if [[ $UID -eq 0 ]]; then
	"$@"
  elif sudo -v &>/dev/null && sudo -l "$@" &>/dev/null; then
	sudo -E "$@"
  else
	echo -n "root "
	su -c "$(printf '%q ' "$@")"
  fi
}

CMD_INSTALL="git clone https://github.com/BrendanThompson/packer.git /usr/local/lib/packer"
CMD_LINK="ln -Fsi /usr/local/lib/packer/packer /usr/local/bin/packer"

if ! [[ -d "/usr/local/libpacker" ]]; then
	echo -e "${COLOR5}:: ${COLOR1}Installing ${COLOR2}packer${ENDCOLOR} ${COLOR1} ...${ENDCOLOR}"
	echo
	runasroot $CMD_INSTALL
	echo
	echo -e "${COLOR5}:: ${COLOR2}Linking to bin ...${ENDCOLOR}"
	echo
	runasroot $CMD_LINK
else
	echo -e "${COLOR7}:: ${COLOR2}packer${ENDCOLOR}${COLOR1} seems to already be installed.${ENDCOLOR}"
	exit 0
fi