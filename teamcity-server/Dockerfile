FROM jetbrains/teamcity-server

ENV TEAMCITY_DATA_PATH /data/teamcity_server/datadir
ENV LIBMYSQL_JAVA_KEY 5072E1F5
RUN gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$LIBMYSQL_JAVA_KEY"
ENV JDBC_MYSQL_MD5 8f8e768a91338328f2ac5cd6b6683c88
ENV JDBC_MYSQL_VERSION 5.1.38
ENV JDBC_MYSQL_URL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz
ENV SLACK_NOTIFICATION_PLUGIN https://github.com/PeteGoo/tcSlackBuildNotifier/releases/download/v1.4.6/tcSlackNotificationsPlugin.zip
ENV SLACK_NOTIFICATION_FILE tcSlackNotificationsPlugin.zip

# Updates the packages and install needed softwares
RUN apt-get update && \
    apt-get install wget 

# Create dir for TeamCity installation
RUN mkdir -p /opt

COPY /jdbc-mysql-$JDBC_MYSQL_VERSION.tar.gz.asc /opt/

# Create the directory for jdbc drivers
RUN mkdir -p $TEAMCITY_DATA_PATH/lib/jdbc
# Create the directory for plugins
RUN mkdir -p $TEAMCITY_DATA_PATH/plugins

# Copy started script
COPY ["docker-entrypoint.sh", "/docker-entrypoint.sh"]

# Fix permissions
RUN chmod 755 /docker-entrypoint.sh

# Set entry point to the starter script
ENTRYPOINT ["/docker-entrypoint.sh"]
