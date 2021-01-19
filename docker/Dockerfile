# This script expects the following placeholder to be replaced before executing:
# - NEO4J VERSION IN FROM PARAM -> latest
# - APOC_VERSION
# - NEO4J_PASSWORD

# Get neo4j image as base image from Docker-Hub
FROM neo4j:latest

# APOC-Version to use
ENV APOC_VERSION=4.2.0.0

# Password to use for Neo4J. Must be the same as in the deploy script
ENV NEO4J_PASSWORD=password

# Create ENV-Var for APOC URI
ENV APOC_URI https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${APOC_VERSION}/apoc-${APOC_VERSION}-all.jar

# Gets current APOC Version from defined APOC_URI ENV and moves the files to the Neo4J plugin folder
RUN wget $APOC_URI && mv apoc-${APOC_VERSION}-all.jar plugins/apoc-${APOC_VERSION}-all.jar

# install curl for future health check (NOT YET IMPLEMENTED)
RUN apt-get update && apt-get install -y curl

# Prepare backup script
RUN apt -y install cron
COPY backup /var/lib/neo4j/backup

# Replace pw placeholder with pass 
RUN sed -i -e "s/\${NEO4J_PASSWORD}/${NEO4J_PASSWORD}/" /var/lib/neo4j/backup/backup.sh

# Prepare and start cron via docker-entrypoint.sh
COPY cron.log /var/lib/neo4j
COPY backupCron /etc/cron.d
RUN sed -i '/cmd=/ a service cron restart' /docker-entrypoint.sh

# Exposed die Ports um darauf zuzugreifen
EXPOSE 7474 7473 7687

# Adapt file permissions (we are not root!)
RUN chmod -R 777 /var/lib/neo4j

# For settings which might be different per environment, use env variables instead of neo4j.conf !
RUN echo "dbms.security.procedures.unrestricted=apoc.*" >> /var/lib/neo4j/conf/neo4j.conf

# Geht zurück auf den Hauptpfad
CMD ["neo4j"]


