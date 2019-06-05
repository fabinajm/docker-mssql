#!/usr/bin/env bash
#!/bin/bash

TOTVS_PATH=/totvs12

mkdir -p $TOTVS_PATH/protheus/{apo,bin/appserver}
mkdir -p $TOTVS_PATH/protheus_data/{system,systemload}

cd $TOTVS_PATH/protheus/bin/appserver/

chmod 777 $TOTVS_PATH/protheus/bin/appserver/*.so

echo $TOTVS_PATH/"protheus/bin/appserver/" > /etc/ld.so.conf.d/appserver64-libs.conf
/sbin/ldconfig

echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc

cp /build/docker-entrypoint.sh /
cp /build/odbc.ini /etc/odbc.ini
cp /build/dbaccess.ini /opt/totvs/dbaccess/multi/
cp /build/init.sql /opt/totvs/
cp /build/appserver.ini $TOTVS_PATH/protheus/bin/appserver/

echo "/opt/totvs/dbaccess/multi/" > /etc/ld.so.conf.d/dbaccess64-libs.conf
/sbin/ldconfig

# Cleanup by wiping the temp directory
cd /
rm -rf /build

