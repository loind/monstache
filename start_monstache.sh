#!/bin/sh

config_path=$1

if [[ ! -f $config_path ]]; then
    echo "$1 does not exist."
    exit
fi

mkdir -p /tmp
cp $config_path /tmp

file_name="${config_path##*/}"

sed -i "s/_MONGO_USER_/$MONGO_BACKUP_USER/" /tmp/$file_name
sed -i "s/_MONGO_PASSWORD_/$MONGO_BACKUP_PASSWORD/" /tmp/$file_name
sed -i "s/_ELASTIC_SEARCH_HOST_/$ELASTIC_SEARCH_HOST/" /tmp/$file_name
sed -i "s/_ELASTIC_SEARCH_PORT_/$ELASTIC_SEARCH_PORT/" /tmp/$file_name
sed -i "s/_ELASTIC_SEARCH_USER_/$ELASTIC_SEARCH_USER/" /tmp/$file_name
sed -i "s/_ELASTIC_SEARCH_PASSWORD_/$ELASTIC_SEARCH_PASSWORD/" /tmp/$file_name

eval $custom_host
/bin/monstache -f /tmp/$file_name
