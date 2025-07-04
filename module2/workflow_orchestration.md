# Workflow Orchestration (Kestra)

### Introduction

Orchestration vs Automation: [auto_&_orches.png](images/auto_&_orches.png)

- Automation refers to the execution of individual tasks or actions without manual intervention. For example, automatically triggering a test suite after a pull request is opened
- Orchestration goes beyond automation by managing the flow of multiple interconnected tasks or processes. It defines not only what happens but also when and how things happen, ensuring that all tasks (whether automated or not) are executed in the correct order, with the right dependencies and error handling in place

Kestra: is a workflow orchestration tool

Related concepts:

- Flows are defined in a declarative YAML syntax to keep the orchestration code portable and language-agnostic. Each flow consists of three required components: id, namespace, and tasks:

   - id: represents the name of the flow
   - namespace: can be used to separate development and production environments
   - tasks: is a list of tasks that will be executed in the order they are defined

- input: allow you to make your flows more dynamic and reusable
- output: allow you to pass data between tasks and flows
- labels: are customizable tags to simplify monitoring and filtering of flows and executions
- descriptions: document your flow's purpose or other useful information
- trigger: automatically start your flow based on events. A trigger can be a scheduled date, a new file arrival, a new message in a queue, or the end of another flow's execution

   - Scheduling: The Schedule trigger generates new executions on a regular cadence based on a Cron expression or custom scheduling conditions

   - Backfills are replays of missed schedule intervals between a defined start and end date

- concurrency limit: allows you to control the number of concurrent executions of a given flow by setting the limit key
- errors: handle errors with automatic retries and notifications
- KV store: is a powerful tool that allows to persist data across executions or even across different workflows

### Practices

- Run Kestra in Docker container: `sudo docker run --pull=always --rm -it -p 8080:8080 --user=root -v /var/run/docker.sock:/var/run/docker.sock -v /tmp:/tmp kestra/kestra:latest server local`

   *connect to Kestra WebUI via `localhost:8080`*

   *--rm: automatically remove the container and its associated anonymous volumes when it exits*
   
- Demo: in Kestra, define flow to
      
   - Build a simple ETL pipeline: [data_pipeline_flow](demo/pipeline/getting_started_data_pipeline.yaml) (pipeline is illustrated at [here](demo/pipeline/pipeline.png)) or

   - Define a flow to automatically run a Python script every hour, get the Github stars, log the results & send a notification to Discord. [api_example_flow](demo/api/api_example.yaml)

### Project: build ETL pipeline with 2 options

- Locally with Postgres
   
   - Run Docker Compose (Kestra + Postgres + pgAdmin): [docker-compose](flows/posgres/docker-compose.yaml)

      *There are 2 Postgres services, one is used to store data for Kestra and one to export to localhost port (connecting to pgAdmin)*

   - In Kestra, define flow to:

      - Create a ETL pipeline: [posgres_taxi_flow](flows/posgres/postgres_taxi.yaml)
      
         - Extract data from [CSV files](https://github.com/DataTalksClub/nyc-tlc-data/releases) (partitioned by taxi type, year & month)
      
         - Load it into Postgres: 

            - Create final & monthly table
            - Load data to the monthly table & transformation
            - Merge transformed data to the final destination table

      - Scheduling & backfilling: [postgres_taxi_scheduled_flow](flows/posgres/postgres_taxi_scheduled.yaml)
      
         - At 9:00 AM, on the 1st day of every month, regardless of the day of the week 
         - Backfill only data for the green taxi dataset for the year 2019

      - dbt:

- Globally with GCP (Google Cloud + BigQuery)

   - Run Docker Compose (Kestra only): [docker-compose](flows/gcp/docker-compose.yaml)

   - In Kestra, define flow to:

      - Setting up KV Store: [gcp_kv_flow](flows/gcp/gcp_kv.yaml)
      
         *Manually set up KV store in Kestra with key="GCP_CREDS" & values=[credentials.json](flows/gcp/keys/credentials.json)*

      - Create GCP resources (GCS & BigQuery): [gcp_setup_flow](flows/gcp/gcp_setup.yaml)
      
      - Create a ETL pipeline: [gcp_taxi_flow](flows/gcp/gcp_taxi.yaml)
      
         - Extract data

         - Upload to GCS
      
         - Load it into BigQuery: include 3 tables

            - Final table to store final results
            - External table: is a table connected to GCS (does not store actual data)
            - Temp table: store transformed data & merge into final table

      - Scheduling & backfilling: [gcp_taxi_scheduled_flow](flows/gcp/gcp_taxi_scheduled.yaml)

      - dbt:    