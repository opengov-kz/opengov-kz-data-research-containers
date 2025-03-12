# Visualizer

## Setup

1. Clone or download this repo and change directory to Visualizer

2. Run Docker Compose
```bash
$ docker compose up -d
```

3. Wait until all services are running healthy

Run
```bash
$ docker compose ps
```

Expected output:
```bash
NAME                     IMAGE                  COMMAND                  SERVICE     CREATED          STATUS                    PORTS
visualizer-pgadmin-1     dpage/pgadmin4:9.1.0   "/entrypoint.sh"         pgadmin     30 minutes ago   Up 30 minutes             443/tcp, 0.0.0.0:5050->80/tcp, [::]:5050->80/tcp
visualizer-superset-1    visualizer-superset    "/superset-init.sh"      superset    19 minutes ago   Up 19 minutes (healthy)   0.0.0.0:8080->8088/tcp, [::]:8080->8088/tcp
visualizer-warehouse-1   postgres:13            "docker-entrypoint.s…"   warehouse   30 minutes ago   Up 30 minutes (healthy)   5432/tcp
```
