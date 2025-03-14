# ETL

### Environment Variables

These are the key environment variables used to configure the services in the system.

### Container Names
| Variable Name                        | Description                        | Default Value                |
|--------------------------------------|------------------------------------|------------------------------|
| `PGADMIN_CONTAINER_NAME`             | pgAdmin container name             | `pgadmin`                    |
| `CLIENT_POSTGRES_CONTAINER_NAME`     | Client PostgreSQL container name   | `client-postgres`            |
| `AIRFLOW_POSTGRES_CONTAINER_NAME`    | Airflow PostgreSQL container name  | `airflow-postgres`           |
| `AIRFLOW_REDIS_CONTAINER_NAME`       | Airflow Redis container name       | `airflow-redis`              |
| `AIRFLOW_WEBSERVER_CONTAINER_NAME`   | Airflow Webserver container name   | `airflow-webserver`          |
| `AIRFLOW_SCHEDULER_CONTAINER_NAME`   | Airflow Scheduler container name   | `airflow-scheduler`          |
| `AIRFLOW_WORKER_CONTAINER_NAME`      | Airflow Worker container name      | `airflow-worker`             |
| `AIRFLOW_TRIGGERER_CONTAINER_NAME`   | Airflow Triggerer container name   | `airflow-triggerer`          |
| `AIRFLOW_INIT_CONTAINER_NAME`        | Airflow Init container name        | `airflow-init`               |
| `AIRFLOW_CLI_CONTAINER_NAME`         | Airflow CLI container name         | `airflow-cli`                |
| `FLOWER_CONTAINER_NAME`              | Flower container name              | `flower`                     |
| `WAREHOUSE_POSTGRES_CONTAINER_NAME`  | Warehouse PostgreSQL container name| `warehouse-postgres`         |
| `SUPERSET_CONTAINER_NAME`            | Superset container name            | `superset`                   |

### Ports

| Variable Name                | Description                    | Default Value |
|------------------------------|--------------------------------|---------------|
| `CLIENT_PGADMIN_PORT`         | pgAdmin external port          | `5050`        |
| `CLIENT_POSTGRES_PORT`        | Client PostgreSQL external port| `5454`        |
| `AIRFLOW_REDIS_PORTS`         | Airflow Redis external port    | `6379`        |
| `AIRFLOW_WEBSERVER_PORT`      | Airflow Webserver external port| `8080`        |
| `FLOWER_PORT`                 | Flower external port           | `5555`        |
| `WAREHOUSE_POSTGRES_PORT`     | Warehouse PostgreSQL ext. port | `5434`        |
| `SUPERSET_PORT`               | Superset external port         | `8081`        |

### Credentials

| Variable Name                        | Description                        | Default Value                |
|--------------------------------------|------------------------------------|------------------------------|
| `PGADMIN_EMAIL`                      | pgAdmin admin email                | `admin@admin.com`            |
| `PGADMIN_PASSWORD`                   | pgAdmin admin password             | `admin`                      |
| `CLIENT_POSTGRES_USER`               | Client PostgreSQL user             | `client`                     |
| `CLIENT_POSTGRES_PASSWORD`           | Client PostgreSQL password         | `client`                     |
| `CLIENT_POSTGRES_DB`                 | Client PostgreSQL database         | `client`                     |
| `AIRFLOW_POSTGRES_USER`              | Airflow PostgreSQL user            | `airflow`                    |
| `AIRFLOW_POSTGRES_PASSWORD`          | Airflow PostgreSQL password        | `airflow`                    |
| `AIRFLOW_POSTGRES_DB`                | Airflow PostgreSQL database        | `airflow`                    |
| `WAREHOUSE_POSTGRES_USER`            | Warehouse PostgreSQL user          | `warehouse`                  |
| `WAREHOUSE_POSTGRES_PASSWORD`        | Warehouse PostgreSQL password      | `warehouse`                  |
| `WAREHOUSE_POSTGRES_DB`              | Warehouse PostgreSQL database      | `warehouse`                  |
| `SUPERSET_ADMIN_USERNAME`            | Superset admin username            | `admin`                      |
| `SUPERSET_ADMIN_EMAIL`               | Superset admin email               | `admin@admin.com`            |
| `SUPERSET_ADMIN_PASSWORD`            | Superset admin password            | `admin`                      |

### Misc
| Variable Name                        | Description                        | Default Value                |
|--------------------------------------|------------------------------------|------------------------------|
| `AIRFLOW_UID`                        | Airflow user ID                    | `1000`                       |

---

## Setup Guide

### 1. Clone the Repository
```bash
git clone https://github.com/opengov-kz/opengov-kz-data-research-containers.git
cd opengov-kz-data-research-containers
```

### 2. Rename `.env.example` to `.env` (Optional)
- Before running the setup, you can rename the `.env.example` file to `.env` to configure your environment variables.
  
```bash
mv .env.example .env
```

- Inside the `.env` file, you can set or modify environment variables like database credentials, port numbers, and service names. By default, the environment variables are pre-configured for ease, but you can customize them if needed. Examples of important variables include:

```bash
# Example environment variables
AIRFLOW_DB_USER=airflow
AIRFLOW_DB_PASSWORD=airflow
CLIENT_DB_USER=client
CLIENT_DB_PASSWORD=client
PGADMIN_EMAIL=admin@example.com
PGADMIN_PASSWORD=admin123
```

Modifying these variables is **optional** based on your requirements.

### 3. Download and Setup Superset Files
- Use a temporary container with the following image: `apache/superset:31e1b63bb3e9f5b3adc289c5580e53d4dcabf277` to get the necessary setup files.
- Run the following command to copy the Superset files:

```bash
docker create --name temp-superset apache/superset:31e1b63bb3e9f5b3adc289c5580e53d4dcabf277
docker cp temp-superset:/app/superset_home ./superset_home
docker rm temp-superset
```

- The `superset_home` directory will be used as a volume in the `docker-compose.yaml` file.

### 4. Prepare Airflow Directories
Create the necessary directories for Airflow:
```bash
mkdir -p ./dags ./logs ./plugins ./config
```

### 5. Initialize Airflow
- Run the Airflow initialization service:
```bash
docker compose up airflow-init
```

- If the output shows the following, you can proceed:
  ```
  airflow-init_1       | Upgrades done
  airflow-init_1       | Admin user airflow created
  airflow-init_1       | 2.10.5
  start_airflow-init_1 exited with code 0
  ```

### 6. Start All Services
- Start all services using Docker Compose:
```bash
docker compose up -d
```
- Wait until all services are healthy and accessible.

### 7. Wait for Services to Become Healthy
- It may take some time for the worker and webserver to fully configure. Wait until everything is healthy and the webserver becomes accessible.

### 8. Verify the Services
- Check the status of your services using the `docker compose ps` command. The expected output should look like this:

```bash
$ docker compose ps
NAME                 IMAGE                   COMMAND                  SERVICE              CREATED       STATUS                       PORTS
airflow-postgres     postgres:13             "docker-entrypoint.s…"   airflow-postgres     2 hours ago   Up 2 hours (healthy)         5432/tcp
airflow-redis        redis:7.2-bookworm      "docker-entrypoint.s…"   airflow-redis        2 hours ago   Up 2 hours (healthy)         0.0.0.0:6379->6379/tcp, [::]:6379->6379/tcp
airflow-scheduler    etl-airflow-scheduler   "/usr/bin/dumb-init …"   airflow-scheduler    2 hours ago   Up About an hour (healthy)   8080/tcp
airflow-triggerer    etl-airflow-triggerer   "/usr/bin/dumb-init …"   airflow-triggerer    2 hours ago   Up About an hour (healthy)   8080/tcp
airflow-webserver    etl-airflow-webserver   "/usr/bin/dumb-init …"   airflow-webserver    2 hours ago   Up 51 minutes (healthy)      0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp
airflow-worker       etl-airflow-worker      "/usr/bin/dumb-init …"   airflow-worker       2 hours ago   Up About an hour (healthy)   8080/tcp
client-postgres      postgres:13             "docker-entrypoint.s…"   client-postgres      2 hours ago   Up 2 hours (healthy)         0.0.0.0:5454->5432/tcp, [::]:5454->5432/tcp
pgadmin              dpage/pgadmin4:9.1.0    "/entrypoint.sh"         pgadmin              2 hours ago   Up About an hour             443/tcp, 0.0.0.0:5050->80/tcp, [::]:5050->80/tcp
superset             etl-superset            "/superset-init.sh"      superset             2 hours ago   Up About an hour (healthy)   0.0.0.0:8081->8088/tcp, [::]:8081->8088/tcp
warehouse-postgres   postgres:13             "docker-entrypoint.s…"   warehouse-postgres   2 hours ago   Up 2 hours (healthy)         0.0.0.0:5434->5432/tcp, [::]:5434->5432/tcp
```

### 9. You're Done!
That's all! You can now start working with the services and access the web interfaces.

--- 