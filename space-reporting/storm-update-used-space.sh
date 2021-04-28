#!/bin/bash
set -e

usage() { echo "Usage: $0 [-u <db-username>] [-p <db-password>] [-a <spacetoken-alias>] [-s <used-space-size>]" 1>&2; exit 1; }

while getopts ":u:p:a:s:" o; do
    case "${o}" in
        u)
            username=${OPTARG}
            ;;
        p)
            password=${OPTARG}
            ;;
        a)
            alias=${OPTARG}
            ;;
        s)
            size=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${alias}" ] || [ -z "${size}" ] || [ -z "${username}" ] || [ -z "${password}" ] ; then
    usage
fi

# echo "u = ${username}"
# echo "p = ${password}"
# echo "a = ${alias}"
# echo "s = ${size}"

echo "Getting space info for '${alias}' ..."

space_info=`mysql -sN -u${username} -p${password} storm_be_ISAM -e "select TOTAL_SIZE, GUAR_SIZE, FREE_SIZE, USED_SIZE, BUSY_SIZE, UNAVAILABLE_SIZE, AVAILABLE_SIZE, RESERVED_SIZE from storage_space where ALIAS = '${alias}'"`

if [ -z "${space_info}" ]; then
  echo "no space record found for alias ${space_info}"
  exit 1
fi

total_size=`echo ${space_info} | awk '{print $1+0}'`
free_size=`echo ${space_info} | awk '{print $3+0}'`
used_size=`echo ${space_info} | awk '{print $4+0}'`

echo "  total_size=${total_size}, free_size=${free_size}, used_size=${used_size}"

new_free_size=$((total_size-size))

echo "Setting new free size as ${new_free_size} and new used space as ${size} ..."

mysql -sN -u${username} -p${password} storm_be_ISAM -e "update storage_space set FREE_SIZE=${new_free_size}, AVAILABLE_SIZE=${new_free_size}, USED_SIZE=${size}, BUSY_SIZE=${size} where ALIAS = '${alias}'"

echo "  Update query exited with $?"

exit 0
