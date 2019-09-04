FROM centos:7

LABEL name="microsoft/mssql-server-linux" \
      vendor="Microsoft" \
      version="14.0" \
      release="1" \
      summary="MS SQL Server" \
      description="MS SQL Server is ....." \
### Required labels above - recommended below
      url="https://www.microsoft.com/en-us/sql-server/" \
      run='docker run --name ${NAME} \
        -e ACCEPT_EULA=Y -e SA_PASSWORD=P@55w0rd \
        -p 1433:1433 \
        -d  ${IMAGE}' \
      io.k8s.description="MS SQL Server is ....." \
      io.k8s.display-name="MS SQL Server"

RUN yum -y update \
    && yum -y install \
        dmidecode \
        fontconfig \
        glib2 \
        glibc \
        libstdc++ \
        libuuid \
      glibc.i686  \
      dejavu-lgc-sans-fonts\
      libexpat.i686 \
      libfreetype.i686  \
      libGL.i686  \
      libICE.i686 \
      libSM.i686  \
      libXcursor.i686 \
      libXext.i686  \
      libXft.i686 \
      libXinerama.i686  \
      libXmu.i686 \
      libXrandr.i686  \
      libXrender.i686 \
      mesa-libGL.i686 \
      wget \
      gcc \
      nc \
    && rm -rf /var/cache/yum/* \
    && yum clean all

# Install latest mssql-server package
RUN curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-2017-gdr.repo && \
    curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/7/prod.repo && \
    ACCEPT_EULA=Y yum install -y mssql-server mssql-tools unixODBC-devel && \
    yum clean all

# COPY uid_entrypoint /opt/mssql-tools/bin/
ENV PATH=${PATH}:/opt/mssql/bin:/opt/mssql-tools/bin
RUN mkdir -p /var/opt/mssql/data && \
    chmod -R g=u /var/opt/mssql /etc/passwd

RUN DUMB_INIT_SHA256="37f2c1f0372a45554f1b89924fbb134fc24c3756efaedf11e07f599494e0eff9" \
    && wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 \
    && echo "37f2c1f0372a45554f1b89924fbb134fc24c3756efaedf11e07f599494e0eff9 */usr/bin/dumb-init" | sha256sum -c - \
    && chmod +x /usr/bin/dumb-init

### Containers should not run as root as a good practice
USER root

ADD 19-02-14-DBACCESS_LINUX_X86_BUILD-20181212.tar.xz /opt/totvs/dbaccess
ADD appsrvlinux.tar.gz /totvs12/protheus/bin/appserver
ADD libctreetmp.tar.gz /totvs12/protheus/bin/appserver
ADD libdtsearch.tar.gz /totvs12/protheus/bin/appserver
ADD printer.tar.gz /totvs12/protheus/bin/appserver
ADD webapp-linux-x86.tar.gz /totvs12/protheus/bin/appserver
ADD tttp120.tar.xz /totvs12/protheus/apo
ADD system.tar.xz /totvs12/protheus_data
ADD systemload.tar.xz /totvs12/protheus_data

ADD /build /build
RUN /build/setup.sh

EXPOSE 7890 1433 8085 8081

WORKDIR /opt/totvs/dbaccess/multi

ENTRYPOINT [ "/usr/bin/dumb-init", "--", "/docker-entrypoint.sh", "sqlcmd -S 127.0.0.1 -U sa -P P@55w0rd -i /opt/totvs/init.sql" ]

CMD ["dbaccess"]
