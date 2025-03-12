# Visualizer

## Setup

1. Clone or download this repo and change directory to Visualizer

2. Copy Superset's home directory

    `!DO SETUP IN VISUALIZER DIRECTORY!`

    - Create temporary container 

    ```bash
    $ docker run --name temp --detach apache/superset:31e1b63bb3e9f5b3adc289c5580e53d4dcabf277   
    ```
    - Copy directory from container

    ```bash
    $ docker cp temp:/app/superset_home ./superset_home   
    ```

    - Delete temporary container
    ```bash
    $ docker container rm -f temp  
    ```

2. Run Docker Compose
    ```bash
    $ docker compose up -d
    ```

3. Wait until all services are running healthy

    List services
    ```bash
    $ docker compose ps
    ```

    Expected output all services must be healthy, if not list again and wait till they're healthy
    ```bash
    NAME                     IMAGE                  COMMAND                  SERVICE     CREATED          STATUS                    PORTS
    visualizer-pgadmin-1     dpage/pgadmin4:9.1.0   "/entrypoint.sh"         pgadmin     30 minutes ago   Up 30 minutes             443/tcp, 0.0.0.0:5050->80/tcp, [::]:5050->80/tcp
    visualizer-superset-1    visualizer-superset    "/superset-init.sh"      superset    19 minutes ago   Up 19 minutes (healthy)   0.0.0.0:8080->8088/tcp, [::]:8080->8088/tcp
    visualizer-warehouse-1   postgres:13            "docker-entrypoint.s…"   warehouse   30 minutes ago   Up 30 minutes (healthy)   5432/tcp
    ```

## Connect Superset to Warehouse DB
Access superset's WebUI on localhost:8080.
1. In the settings press Database Connections
    ![](md/superset-createdb-access-webui.png)
    Press Create database connection button
    After that you should see pop-up window
    ![](md/superset-createdb-press-createdb-button.png)

2. Choose postgres in pop-up window
![](md/superset-createdb-choose-postgres.png)

3. Configure Connection
Here in hostnames we pass warehouse, because Superset and Warehouse db are in the same dockerc network and Warehouse's hostname is `warehouse`
![](md/superset-createdb-configure-postgres-1.png)


4. Here you can tinker connection options for you
![](md/superset-createdb-configure-postgres-2.png)

5. Here's the expected output
![](md/superset-createdb-output.png)

## Connect PGAdmin to Warehouse DB

1. Access PGAdmin WebUI on localhost:5050
    Right click on servers and press register > server
    ![](md/pgadmin-connectdb-create-server-button.png)

2. Set server name in pop-up window
    ![](md/pgadmin-connectdb-configure-1.png)

3. Configure connection
    
    just `warehouse` everything

    Here in hostnames we pass warehouse, because Superset and Warehouse db are in the same dockerc network and Warehouse's hostname is `warehouse`
        ![](md/pgadmin-connectdb-configure-2.png)

4. Configure connection parameters
    ![](md/pgadmin-connectdb-configure-3.png)
5. Configure ssh tunnel (if you need, otherwise don't touch that)
    ![](md/pgadmin-connectdb-configure-4.png)
6. Configure advanced settings (if you need)
    ![](md/pgadmin-connectdb-configure-5.png)
7. Set tags (if you need) and hit save if you finished
    ![](md/pgadmin-connectdb-configure-6.png)
8. Here's the expected output
    ![](md/pgadmin-connectdb-output.png)
9. Go to query tool workspace and set server that you created
    then hit connect
    ![](md/pgadmin-connectdb-test-1.png)
10. Write and execude some sql statements;
    ![](md/pgadmin-connectdb-test-2.png)