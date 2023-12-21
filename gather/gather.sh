#!/bin/sh

info() {
	echo "$@"
}

die() {
	info "$@" && exit 1
}

precheck_file() {
	info "checking file '$1'..."

	if [ ! -f "$1" ]; then
		die "unable to find file '$1', aborting"
	fi
}

gather_files() {
	info "gathering files from a filesystem..."

	files=" $HOME/.xsession
		$HOME/.profile"

	for file in $files; do
		precheck_file "$file"
	done
}

check_env() {
	eval [ -z "$1" ] && die "variable '$1' is not set"
}

main() {
	check_env '$HOME'

	case $1 in
	gather)
		gather_files
		;;
	*)
		die "usage: $0 [gather]"
		;;
	esac
}

main "$@"
