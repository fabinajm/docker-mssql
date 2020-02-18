# CENTOS 7 - TOTVS Protheus - MSSQL - Docker 64bits

## O que é Docker ?

Docker é um _runtime_ para execução de LinuX _Containers_ (LXC). Este repositório contém um conjunto de scripts para construir uma imagem do protheus com o mssql que poderá ser executada em qualquer host Linux que tenha o [Docker Engine](https://docs.docker.com/installation/) instalado.

## Como usar esta imagem ?

Instale o Docker Compose (https://docs.docker.com/compose/install/) e clone o repositório Git:

$ git clone https://github.com/fabinajm/docker-mssql

Baixe o rpo (.tar.xz - https://www.dropbox.com/s/l626mb2094z9y76/tttp120.tar.xz?dl=0) e copie para a pasta docker-mssql do git. 
Abra o terminal e acesse a pasta do repositório (docker-mssql), rode os comandos:

$ sudo docker-compose build 

$ sudo docker-compose up

Acesse o data azure studio (https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017), acesse como localhost, usuário: sa, senha: P@55w0rd

Abra o arquivo init.sql, e rode-o.

O protheus estará pronto para ser acessado na porta: 8081, environment: local.

## Como usar o container ?

Para rodar o container, acesse a pasta (docker-mssql) e rode o comando:

$ sudo docker-compose up -d

Para entrar dentro das pastas do container, rode o comando:

$ sudo docker exec -t -i totvsdockermssql_dbaccess_1 bash

Para copiar arquivos entre o computador e o container.

Computador para Container:

$ sudo docker cp foo.txt totvsdockermssql_dbaccess_1:/foo.txt

Container para Computador:

$ sudo docker cp totvsdockermssql_dbaccess_1:/foo.txt foo.txt

Para listar os containers em execução:

$ sudo docker ps

Para parar a execução do container:

$ sudo docker stop totvsdockermssql_dbaccess_1

# Referência

* https://github.com/endersonmaia/totvs-protheus-docker
* https://cardano.github.io/blog/2017/11/15/mssql-docker-container
* https://registry.centos.org/microsoft/mssql-server-linux/latest
* https://medium.com/the-code-review/run-bash-or-any-command-in-a-docker-container-9a1e7f0ec204
* https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-2017
* https://www.shellhacks.com/docker-cp-command-copy-file-to-from-container/
