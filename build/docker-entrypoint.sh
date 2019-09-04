#!/usr/bin/env bash
set -e

password=P@55w0rd

export DB_HOST=LOCALHOST
export DB_PORT=1433
export DB_USER=siga
export DB_PASS=sig@1234
export DB_NAME=DadosADV
export DBACCESS_SERVER=localhost
export DBACCESS_ALIAS=protheus
export DBACCESS_PORT=7890

export LICENSE_SERVER=${LICENSE_SERVER:-127.0.0.1}
export LICENSE_SERVER_PORT=${LICENSE_SERVER_PORT:-5555}

/bin/sed 's/{{LICENSE_SERVER}}/'"${LICENSE_SERVER}"'/' -i /opt/totvs/dbaccess/multi/dbaccess.ini
/bin/sed 's/{{LICENSE_SERVER_PORT}}/'"${LICENSE_SERVER_PORT}"'/' -i /opt/totvs/dbaccess/multi/dbaccess.ini

/opt/totvs/dbaccess/multi/dbaccess &

/opt/mssql/bin/sqlservr &

/totvs12/protheus/bin/appserver/appsrvlinux

exec "$@"
