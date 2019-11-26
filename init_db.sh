#!/usr/bin/env bash

if [[ $1 = "-h" || $1 = "help" || $1 = "--help" ]]; then
    echo "Usage:
    sh ./init_db.sh : initialize databse
"
fi

read -r -p "Enter your db username:" db_user

read -r -s -p "Enter your db password:" db_pwd
echo ""

read -r -p "Enter your db host address (default 127.0.0.1):" db_host
if [[ ${db_host} = "" ]]; then
    db_host="127.0.0.1"
fi

read -r -p "Enter your db port (default 3306):" db_port
if [[ ${db_port} = "" ]]; then
    db_port="3306"
fi

export MYSQL_PWD=$db_pwd

echo ""
echo "- Initializing My Connect database"
mysql --host=${db_host} --user="${db_user}" --port="${db_port}" < createdb.sql
echo "- Initializing My Connect tables"
mysql --host=${db_host} --user="${db_user}" --port="${db_port}" --database="mc_97418e93d514bfe7a5e1ffb7fbfa5203" < createtable.sql

echo "- Inserting installation data"
sh ./data.sh ${db_user} ${db_host} ${db_port} ${db_pwd}

echo "- All done!"