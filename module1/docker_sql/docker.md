# Docker

### Introduction

Definition, related concepts and architecture: https://phuockhai.notion.site/Docker-2101e0bbbf398003813af085914d353d

Some examples to test:

- Running the first Docker Container: `docker run hello-world`
   
     *Docker checks whether there is a hello-world image locally. If not, pulls the image from Docker Hub. Then run the container based on the image*

- Running bash in Ubuntu image: `docker run -it ubuntu bash`
  
     *-i: interactive*
     
     *-t: terminal*

- Running Python image: `docker run -it --entrypoint=bash --privileged python:3.9`

     *--entrypoint: overwrite the default ENTRYPOINT of the image (python shell to bash shell)*

     *--privileged: give extended privileges*

- Building an image & running container
     
     `docker build -t test:pandas .` (. is path to [Dockerfile](test/Dockerfile))

     *-t: define tag*

     `docker run -it test:pandas 2021-01-15 123 hello` (this is the sample arguments)

### Ingesting data to PostgreSQL

1. Running PostgreSQL: `docker run -it --name pgdatabase -e POSTGRES_USER="root" -e POSTGRES_PASSWORD="root" -e POSTGRES_DB="ny_taxi" -v db_volume:/var/lib/postgresql/data -p 5432:5432 --network=pg_network  postgres:13-bullseye`

     *--name: name of a container*

     *-e: configure Postgres server by setting environment variables*

     *-v: bind mount a volume to the container* (firstly create db_volume via `docker volume create db_volume`)

     *-p: publish a container's port to the host*

     *--network: connect a container to a network*

2. Work with PostgreSQL: using pgcli or pgAdmin

     - pgcli: python libary to administration for PostgreSQL by CLI: `pgcli -h localhost -p 5432 -u root -d ny_taxi` 

     - pgAdmin: GUI tool to administration for PostgreSQL: `docker run -it -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" -e PGADMIN_DEFAULT_PASSWORD="root" -p 8080:80 --network=pg_network --name pgadmin dpage/pgadmin4`

          *Create a network to connect pgAdmin to PostgreSQL (because pgAdmin and PostgreSQL run on 2 independent containers)*: `docker network create pg_network`

3. Ingesting process: 3 options
     
     - Option 1: run [upload_data.ipynb](upload_data.ipynb) (*can only be run with csv files downloaded locally*)

     - Option 2: parameterization via [ingest_data.py](ingest_data.py). On terminal, run

          URL="https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2021-01.parquet"

          `python ingest_data.py --user=root --password=root --host=localhost --port=5432 --db=ny_taxi --tb=yellow_taxi_trips --url=${URL}`

     - Option 3: dockerizing

          - `docker build -t taxi_ingest:v001 .` (via [Dockerfile](Dockerfile))

          - `docker run -it --network=pg_network taxi_ingest:v001 --user=root --password=root --host=pgdatabase --port=5432 --db=ny_taxi --tb=yellow_taxi_trips --url=${URL}`

### Docker Compose 

Combine step 1 and 2 in [Ingesting data to PostgreSQL](#ingesting-data-to-postgresql): `docker compose up` (via [docker-compose.yaml](docker-compose.yaml))

*If you don't specify a network, Docker Compose will automatically create a network to link the services in it together*

### SQL

On pgAdmin, run SQL queries in
[query.sql](query.sql) (firstly run Preparing SQL part in [upload_data.ipynb](upload_data.ipynb))