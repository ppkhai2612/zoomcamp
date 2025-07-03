### Docker

**Question 1**: What's the version of pip in the image when run docker with the python:3.12.8 image in an interactive mode, use the entrypoint bash?

`docker run -it --entrypoint bash python:3.12.8`

`pip --version`

=> 24.3.1

**Question 2**: What is the hostname and port that pgadmin should use to connect to the postgres database? (Given the following [docker-compose.yaml](docker-compose.yaml))

=> db:5432 hoặc postgres:5432

### Prepare Postgres and query

- Download [green_tripdata_2019-10](../docker_sql/data/green_tripdata_2019-10.csv) and [taxi_zone_lookup](../docker_sql/data/taxi_zone_lookup.csv) csv
- Uploading to Postgres: [upload-data.ipynb](upload-data.ipynb)
- Query: [query.sql](query.sql) 

**Question 3**: During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, respectively, happened?:

- Up to 1 mile: 104,802
- In between 1 (exclusive) and 3 miles (inclusive): 198,924
- In between 3 (exclusive) and 7 miles (inclusive): 109,603
- In between 7 (exclusive) and 10 miles (inclusive): 27,678
- Over 10 miles: 35,189

**Question 4**: Which was the pick up day with the longest trip distance?

=> 2019-10-31

**Question 5**: Which were the top three pickup locations with over 13,000 in total_amount (across all trips) for 2019-10-18?

=> East Harlem North, East Harlem South, Morningside Heights

**Question 6**: For the passengers picked up in October 2019 in the zone named "East Harlem North" which was the drop off zone that had the largest tip?

=> JFK Airport

### Creating resources in GCP with Terraform

**Question 7**: Which of the following sequences, respectively, describes the workflow for:
- Downloading the provider plugins and setting up backend: `terraform init` (initialize plugins & backend via [main.tf](main.tf))
- Generating proposed changes and auto-executing the plan: `terraform apply -auto-approve` 
- Remove all resources managed by terraform: `terraform destroy`