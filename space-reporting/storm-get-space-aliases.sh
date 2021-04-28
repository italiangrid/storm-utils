#!/bin/bash
set -e

usage() { echo "Usage: $0 [-u <db-username>] [-p <db-password>]" 1>&2; exit 1; }

while getopts ":u:p:" o; do
    case "${o}" in
        u)
            username=${OPTARG}
            ;;
        p)
            password=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${username}" ] || [ -z "${password}" ] ; then
    usage
fi

# echo "u = ${username}"
# echo "p = ${password}"

mysql -sN -u${username} -p${password} storm_be_ISAM -e "select ALIAS from storage_space order by ALIAS ASC"

exit 0
