#!/bin/sh
set -e

cat /etc/hosts

mkdir -p $TEAMCITY_DATA_PATH/lib/jdbc $TEAMCITY_DATA_PATH/config
if [ ! -f "$TEAMCITY_DATA_PATH/lib/jdbc/$TEAMCITY_POSTGRE_JDBC_DRIVER" ];
then
    echo "Downloading mysql MYSQL driver..."
    wget -nv $JDBC_MYSQL_URL -O /opt/jdbc-mysql-$JDBC_MYSQL_VERSION.tar.gz && \
    echo "$JDBC_MYSQL_MD5 */opt/jdbc-mysql-$JDBC_MYSQL_VERSION.tar.gz" | md5sum -c - && \
        (>&2 ls -l /opt/jdbc-mysql-$JDBC_MYSQL_VERSION.tar.gz /opt/jdbc-mysql-$JDBC_MYSQL_VERSION.tar.gz.asc) && \
        gpg --verify /opt/jdbc-mysql-$JDBC_MYSQL_VERSION.tar.gz.asc && \
        tar -C $TEAMCITY_DATA_PATH/lib/jdbc --extract --file /opt/jdbc-mysql-$JDBC_MYSQL_VERSION.tar.gz --strip-components=1 && \
        rm /opt/jdbc-mysql-$JDBC_MYSQL_VERSION.tar.gz*
fi

echo "Starting TeamCity Server $TEAMCITY_VERSION..."
exec /opt/teamcity/bin/teamcity-server.sh run