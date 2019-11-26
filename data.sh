#!/bin/bash

# db config
DB_USER=$1
DB_HOST=$2
DB_PORT=$3
DB_PASSWORD=$4
DB_NAME=mc_97418e93d514bfe7a5e1ffb7fbfa5203

export MYSQL_PWD=$DB_PASSWORD

# ing node 1
ING_NODE1_ENDPOINT=127.0.0.1:9091
ING_NODE1_NAME=ING-Bamboo-MyConnect-01
ING_NODE1_ID=84cc54e296706daf29c29f7b0a806165621c497b1dd8056a74e10a48afd1c066
ING_NODE1_PK_PATH=./myconnect-identity.pub
ING_NODE1_PUB_KEY_TYPE=2

# ing node 2
ING_NODE2_ENDPOINT=127.0.0.1:9091
ING_NODE2_NAME=ING-Bamboo-MyConnect-02
ING_NODE2_ID=7f784efba0bebe0e8dfbbe7b062125d732b2feb640352462d3b27414382cb96a
ING_NODE2_PK_PATH=./myconnect-identity.pub
ING_NODE2_PUB_KEY_TYPE=2

# ing app
BAMBOO_ING_APP_NAME=bamboo-inghk
BAMBOO_ING_APP_ID=068c174173c244a97b5dc8afa74980e371bcc49ab5a82e762b1143baef1ea374

# mychain app
MYCHAIN_APP_NAME=mychain
MYCHAIN_APP_ID=1d0b6a1a0f0c2690261a8d44855578f4040b9506e74b5269ee03a241f59f68ee

# admin id (ServiceHub)
ADMIN_ID=f0f75a342fc5d3a6220cae3ac0b3dee872514fb6c4f2dbcb3035aee05c593f9a

if [ ! -f "$ING_NODE1_PK_PATH" ]; then
  echo "ERROR: file $ING_NODE1_PK_PATH doesn't exist"
  exit 1;
fi

if [ ! -f "$ING_NODE2_PK_PATH" ]; then
  echo "ERROR: file $ING_NODE2_PK_PATH doesn't exist"
  exit 1;
fi

now=$(date +'%F %T')
node1_pk=$(cat $ING_NODE1_PK_PATH)
node2_pk=$(cat $ING_NODE2_PK_PATH)

# insert table versions
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`table_versions\` (\`table\`, \`version\`) VALUES ('db_users','2000-01-01 01:00:00');"
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`table_versions\` (\`table\`, \`version\`) VALUES ('db_app_users','2000-01-01 01:00:00');"
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`table_versions\` (\`table\`, \`version\`) VALUES ('db_programs','2000-01-01 01:00:00');"
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`table_versions\` (\`table\`, \`version\`) VALUES ('db_apps','2000-01-01 01:00:00');"
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`table_versions\` (\`table\`, \`version\`) VALUES ('db_public_keys','2000-01-01 01:00:00');"

# insert users
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`db_users\` (\`id\`, \`name\`, \`end_point\`, \`enable_tls\`, \`status\`, \`roles\`, \`create_time\`, \`last_modify_time\`) VALUES ('$ING_NODE1_ID','$ING_NODE1_NAME', '$ING_NODE1_ENDPOINT', true, 1, 1, '$now', '$now');"
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`db_users\` (\`id\`, \`name\`, \`end_point\`, \`enable_tls\`, \`status\`, \`roles\`, \`create_time\`, \`last_modify_time\`) VALUES ('$ING_NODE2_ID','$ING_NODE2_NAME', '$ING_NODE2_ENDPOINT', true, 1, 1, '$now', '$now');"

# insert app
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`db_apps\` (\`id\`, \`name\`, \`admin_id\`, \`status\`, \`create_time\`, \`last_modify_time\`) VALUES ('$BAMBOO_ING_APP_ID','$BAMBOO_ING_APP_NAME', '$ADMIN_ID', 1, '$now', '$now');"
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`db_apps\` (\`id\`, \`name\`, \`admin_id\`, \`status\`, \`create_time\`, \`last_modify_time\`) VALUES ('$MYCHAIN_APP_ID','$MYCHAIN_APP_NAME', '$ADMIN_ID', 1, '$now', '$now');"

# insert app user
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`db_app_users\` (\`app_id\`, \`app_name\`, \`user_id\`, \`user_name\`, \`approved\`, \`create_time\`, \`last_modify_time\`) VALUES ('$BAMBOO_ING_APP_ID','$BAMBOO_ING_APP_NAME', '$ING_NODE1_ID', '$ING_NODE1_NAME', true, '$now', '$now');"
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`db_app_users\` (\`app_id\`, \`app_name\`, \`user_id\`, \`user_name\`, \`approved\`, \`create_time\`, \`last_modify_time\`) VALUES ('$BAMBOO_ING_APP_ID','$BAMBOO_ING_APP_NAME', '$ING_NODE2_ID', '$ING_NODE2_NAME', true, '$now', '$now');"
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`db_app_users\` (\`app_id\`, \`app_name\`, \`user_id\`, \`user_name\`, \`approved\`, \`create_time\`, \`last_modify_time\`) VALUES ('$MYCHAIN_APP_ID','$MYCHAIN_APP_NAME', '$ING_NODE1_ID', '$ING_NODE1_NAME', true, '$now', '$now');"
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`db_app_users\` (\`app_id\`, \`app_name\`, \`user_id\`, \`user_name\`, \`approved\`, \`create_time\`, \`last_modify_time\`) VALUES ('$MYCHAIN_APP_ID','$MYCHAIN_APP_NAME', '$ING_NODE2_ID', '$ING_NODE2_NAME', true, '$now', '$now');"

# insert public key
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`db_public_keys\` (\`user_id\`, \`type\`, \`alias\`, \`key\`, \`create_time\`, \`last_modify_time\`) VALUES ('$ING_NODE1_ID', '$ING_NODE1_PUB_KEY_TYPE', 1, '$node1_pk', '$now', '$now');"
mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --database=$DB_NAME --execute=\
"INSERT INTO \`db_public_keys\` (\`user_id\`, \`type\`, \`alias\`, \`key\`, \`create_time\`, \`last_modify_time\`) VALUES ('$ING_NODE2_ID', '$ING_NODE2_PUB_KEY_TYPE', 1, '$node2_pk', '$now', '$now');"
