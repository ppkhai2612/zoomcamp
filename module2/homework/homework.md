### Assignment

- Leverage the backfill functionality in the scheduled flow to backfill the data for the year 2021. Just make sure to select the time period for which data exists (from 2021-01-01 to 2021-07-31) and for both yellow and green taxi data.

    Solution:
    - Run [docker-compose](../flows/gcp/docker-compose.yaml)
    - In Kestra, run the flows in the following order:
        - [gcs_ky_flow](../flows/gcp/gcp_kv.yaml)
        - [gcs_setup_flow](../flows/gcp/gcp_setup.yaml)
        - [gcs_taxi_scheduled_flow](../flows/gcp/gcp_taxi_scheduled.yaml) (need to adjust start date is 2021-01-01 & end date is 2021-07-31 of backfill before running) 

- Alternatively, run the flow manually for each of the seven months of 2021 for both yellow and green taxi data. Challenge for you: find out how to loop over the combination of Year-Month and taxi-type using ForEach task which triggers the flow for each combination using a Subflow task.

### Quiz Questions

1. Within the execution for Yellow Taxi data for the year 2020 and month 12: what is the uncompressed file size (the output file yellow_tripdata_2020-12.csv of the extract task)?

    => 128.3 MiB

2. What is the rendered value of the variable file when the inputs taxi is set to green, year is set to 2020, and month is set to 04 during execution?

    => green_tripdata_2020-04.csv

3. How many rows are there for the Yellow Taxi data for all CSV files in the year 2020?

    => 24,648,499

4. How many rows are there for the Green Taxi data for all CSV files in the year 2020?

    => 1,734,051

5. How many rows are there for the Yellow Taxi data for the March 2021 CSV file?

    => 1,925,152

6. How would you configure the timezone to New York in a Schedule trigger?

    => Add a timezone property set to America/New_York in the Schedule trigger configuration