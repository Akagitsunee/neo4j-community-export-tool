# About  
The Neo4J-Export-Tool is a bash script directly implemented into the Neo4J original image and runs as a script inside the container executed by CRON.

I made this implementation because there is no proper runtime backup support in the community edition.

Exported Cypher scripts are found in the **<neo4j-home>/import** folder.

**THIS WILL NOT REPLACE THE ENTERPRISE BACKUP TOOL. PLEASE BUY THE ENTERPRISE EDITION FOR PROPER SUPPORT!**

# Installation

1. Clone repository
2. Replace "00 12,22 \* \* \*" in backupCron with desired CRON expression
3. Do as written in following files (read comments in files):

   - Dockerfile
   - backup.sh (Timezone)
   - deploy.sh
   - Feel free to change everything else

4. Execute docker build inside docker folder

```bash
# Example docker build
# Image name (neo4j-export) must be replaced in deploy.sh if not built like this
docker build -t neo4j-export .
```

5. Execute deploy.sh script in resources/scripts
6. Access interface with localhost:7474
7. Enjoy

# Misc

- Execute the following command to access inside of container:

```bash
# Replace [CONTAINER_ID] with container id (docker container ls)
docker exec -it [CONTAINER_ID] /bin/bash
```

- Check memory setting in docker daemon and deploy.sh if container is hung up in a restart loop

# TODO

- Move all params/varables to central file
- Write the same utility with admin-tool support

# Disclaimer  
DO NOT USE THIS UTILITY IF YOU HAVE 1M+ NODES AND DON'T KNOW WHAT YOU DO!  
THE SCRIPTS USE A FAIR SHARE OF RESSOURCES!  

**THIS WILL NOT REPLACE THE ENTERPRISE BACKUP TOOL. PLEASE BUY THE ENTERPRISE EDITION FOR PROPER SUPPORT!**

# License

[MIT](LICENSE.txt)
