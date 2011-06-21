#   apt_completion - APT-related completion functions for bash
#
#   Copyright (C) 2007 Martin Nordholts <enselic@gmail.com>
#
#   This file heavily based on 'bash_completion' which is
#   Copyright (C) Ian Macdonald <ian@caliban.org>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2, or (at your option)
#   any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software Foundation,
#   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
#   Last edited: 2007-03-24

############################################################
########################    SETUP    #######################


# These variables specifies what aliases you want

SUDO_APT_GET_INSTALL_ALIAS=sagi
SUDO_APT_GET_REMOVE_ALIAS=sagr
APT_CACHE_SHOW_ALIAS=acsh
APT_CACHE_SEARCH_ALIAS=acs


########################  END SETUP  #######################
############################################################

# features supported by bash 2.05 and higher
if [ ${BASH_VERSINFO[0]} -eq 2 ] && [[ ${BASH_VERSINFO[1]} > 04 ]] ||
   [ ${BASH_VERSINFO[0]} -gt 2 ]; then
	filenames="-o filenames"
fi

# declare the aliases
alias $SUDO_APT_GET_INSTALL_ALIAS='sudo apt-get install'
alias $SUDO_APT_GET_REMOVE_ALIAS='sudo apt-get remove'
alias $APT_CACHE_SHOW_ALIAS='apt-cache show'

#does not require completion, but is useful to have aliased
alias $APT_CACHE_SEARCH_ALIAS='apt-cache search'



#
# initialize completion
#

# This function checks whether we have a given program on the system.
# No need for bulky functions in memory if we don't.
#
have()
{
	unset -v have
	PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin type $1 &>/dev/null &&
		have="yes"
}

have apt-get &&
_apt_get_install()
{
	local cur

	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}

	COMPREPLY=( $( apt-cache pkgnames $cur 2> /dev/null ) )
	return 0
} &&
complete -F _apt_get_install $filenames $SUDO_APT_GET_INSTALL_ALIAS

have apt-get &&
_apt_get_remove()
{
	local cur

	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}

	if [ -f /etc/debian_version ]; then
		# Debian system
		COMPREPLY=( $( _comp_dpkg_installed_packages \
				$cur ) )
	else
		# assume RPM based
		_rpm_installed_packages
	fi

	return 0
} &&
complete -F _apt_get_remove $filenames $SUDO_APT_GET_REMOVE_ALIAS

have apt-cache &&
_apt_cache_show()
{
	local cur

	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	
	COMPREPLY=( $( apt-cache pkgnames $cur 2> /dev/null ) )

	return 0
} &&
complete -F _apt_cache_show $filenames $APT_CACHE_SHOW_ALIAS



#
# setup get-packages functions
#

have dpkg && {
have grep-status && {
_comp_dpkg_installed_packages()
{
	grep-status -P -e "^$1" -a -FStatus 'install ok installed' -n -s Package
}
} || {
_comp_dpkg_installed_packages()
{
	grep -A 2 "Package: $1" /var/lib/dpkg/status | \
		grep -B 2 'ok installed' | grep "Package: $1" | cut -d\  -f2
}
}
}

have rpm &&
_rpm_installed_packages()
{
	local ver nodig nosig

	if [ -r /var/log/rpmpkgs -a \
		/var/log/rpmpkgs -nt /var/lib/rpm/Packages ]; then
		# using RHL 7.2 or later - this is quicker than querying the DB
		COMPREPLY=( $( sed -ne \
		's|^\('$cur'.*\)-[0-9a-zA-Z._]\+-[0-9a-z.@]\+.*\.rpm$|\1|p' \
				/var/log/rpmpkgs ) )
	else
		nodig=""
		nosig=""
		ver=$(rpm --version)
		ver=${ver##* }
	  
		if [[ "$ver" > "4.0.4" ]]; then
			nodig="--nodigest"
		fi
		if [[ "$ver" > "4.0.99" ]]; then
			nosig="--nosignature"
		fi

		COMPREPLY=( $( rpm -qa $nodig $nosig | sed -ne \
		's|^\('$cur'.*\)-[0-9a-zA-Z._]\+-[0-9a-z.@]\+$|\1|p' ) )
	fi
}
