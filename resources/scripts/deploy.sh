# This script expects the following placeholder to be replaced before executing:
# - CONTAINER_NAME
# - NEO4J_PASSWORD
# - IMAGE
# - HTTP_PORT
# - HTTPS_PORT
# - BOLT_PORT
# - DBMS_MEMORY_HEAP_SIZE
# - DBMS_MEMORY_PAGECACHE_SIZE
# - DBMS_TX_STATE_MAX_OFF_HEAP_MEMORY

CONTAINER_NAME=dev

# Create volumes
docker volume create neo4j-data-$CONTAINER_NAME
docker volume create neo4j-logs-$CONTAINER_NAME
docker volume create neo4j-import-$CONTAINER_NAME

set -e

# Replace with whatever you wish
HTTP_PORT=7474
HTTPS_PORT=7473
BOLT_PORT=7687
DBMS_MEMORY_HEAP_SIZE=6g
DBMS_MEMORY_PAGECACHE_SIZE=2g
DBMS_TX_STATE_MAX_OFF_HEAP_MEMORY=1g

# Replace password with password
NEO4J_PASSWORD=password

# Replace neo4j with image version
IMAGE=neo4j-export

echo "start deployment of neo4j for $CONTAINER_NAME"

docker ps -a

# remove old container
# don't exit if stop or rm fails
set +e
docker stop neo4j-$CONTAINER_NAME
docker rm neo4j-$CONTAINER_NAME
set -e

docker ps -a

docker run -d -p $HTTPS_PORT:7473 -p $HTTP_PORT:7474 -p $BOLT_PORT:7687 \
--name neo4j-$CONTAINER_NAME \
--restart always \
-v neo4j-data-$CONTAINER_NAME:/data \
-v neo4j-logs-$CONTAINER_NAME:/logs \
-v neo4j-import-$CONTAINER_NAME:/var/lib/neo4j/import \
--env NEO4J_dbms_memory_heap_max__size=$DBMS_MEMORY_HEAP_SIZE \
--env NEO4J_dbms_memory_heap_initial__size=$DBMS_MEMORY_HEAP_SIZE \
--env NEO4J_dbms_memory_pagecache_size=$DBMS_MEMORY_PAGECACHE_SIZE \
--env NEO4J_dbms_tx__state_memory__allocation=OFF_HEAP \
--env NEO4J_dbms_memory_off_heap_max_size=$DBMS_TX_STATE_MAX_OFF_HEAP_MEMORY \
--env NEO4J_apoc_export_file_enabled=true \
--env NEO4J_AUTH=neo4j/$NEO4J_PASSWORD \
$IMAGE

sleep 2

echo "deployment finished of neo4j for $CONTAINER_NAME"