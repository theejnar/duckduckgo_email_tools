#/bin/bash

print_usage ()
{
	echo "Usage:";
	echo "./duckduckgo_email_send_address.sh [TO_ADDRESS] [DUCKDUCKGO_EMAIL]";
	echo "or";
	echo "./duckduckgo_email_send_address.sh [ADDRESS_LIST_FILE]";
	echo "where [ADDRESS_LIST_FILE] is typed as follows:";
	echo "[TO_ADDRESS_0] [DUCKDUCKGO_EMAIL_0]";
	echo "[TO_ADDRESS_1] DUCKDUCKGO_EMAIL_1]";
	echo "etc...";
	echo
	echo "Note that when running the script from Git Bash you need to replace ./duckduckgo_email_send_address.sh... with sh duckduckgo_email_send_address.sh"
}

create_send_address () { echo "$1" | sed 's/ /_/' | sed '0,/@/{s/@/_at_/}' | sed 's/$/, /'; }

arguments=( "$@" )

while test $# -gt 0
do
    case "$1" in
        --help) print_usage
		exit 0
            	;;
        -h)	print_usage
	    	exit 0
            	;;
	-*) 	echo "bad option $1"
	    	;;
        --*) 	echo "bad option $1"
            	;;
    esac
    shift
done

if [ "${#arguments[@]}" -eq 1 ]; then
	while read l; do
		create_send_address "$l"
	done <${arguments[0]}
elif [ "${#arguments[@]}" -eq 2 ]; then
	create_send_address "${arguments[0]} ${arguments[1]}"
else
	echo "To many / few arguments."
	print_usage;
	exit 1
fi
