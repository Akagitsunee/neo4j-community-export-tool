# This script expects the following variables to be replaced before executing:
# - datetime to the wished timezone 

echo "------------------------"
echo "Starting backup script!"
echo "------------------------"

echo "Execute backup action!"
{
    export JAVA_HOME=/usr/local/openjdk-11
    export PATH=$JAVA_HOME/bin:$PATH

    # Execute query and export to backup-query.cypher file
    /var/lib/neo4j/bin/cypher-shell -u neo4j -p ${NEO4J_PASSWORD} --file /var/lib/neo4j/backup/backup-query.cypher

    # Replace with timezone
    dateTime=$(TZ='Europe/Berlin' date +"%Y%m%d-%T")

    # Rename backup file to backup with excact datetime of backup 
    echo "Rename backup file to backup-$dateTime.cypher!"
    mv /var/lib/neo4j/import/backup.cypher /var/lib/neo4j/import/backup-$dateTime.cypher

    echo ""
    echo "------------------------"
    echo "Backup completed!"
    echo "------------------------"
}