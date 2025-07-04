### Connecting to GCS

**Uploading data to GCS**:`gsutil -m cp -r data/parquet/ gs://nytaxi_data-lake/pq`

*Note: already have a Service Account with keys that grant permissions to Cloud Storage*

*If permission-related error happend , run the following command to activate service account through key*
`gcloud auth activate-service-account zoomcamp-gcs@zoomcamp-spark.iam.gserviceaccount.com --key-file=keys/credentials.json`

**Downloading from GCS to local**

Following *Connector setup on non-Dataproc clusters* part in [Cloud Storage connector](https://cloud.google.com/dataproc/docs/concepts/connectors/cloud-storage?_gl=1*17sk2iz*_up*MQ..&gclid=CjwKCAjwsZPDBhBWEiwADuO6yyNJZ8B1-EFHl73meStK_E4RouCV5RtG_9uFPz9lR3SqmYc1v4DGqRoCdDQQAvD_BwE&gclsrc=aw.ds)

- Running `gsutil cp gs://hadoop-lib/gcs/gcs-connector-hadoop3-2.2.5.jar lib/gcs-connector-hadoop3-2.2.5.jar`
- Running [spark_gcs.ipynb](spark_gcs.ipynb)

### Creating a Local Spark Cluster

Using spark-submit for submitting spark jobs:
- Starting a Standalone cluster manager: run `.../sbin/start-master.sh`
    *Default, the master of cluster will communicate via port 7077*
- Creating a Spark worker: run `.../sbin/start-worker.sh spark://khai2612-Latitude-5480:7077`
- Convert a notebook to an executable script (usually Python): run `jupyter nbconvert --to=script spark_sql.ipynb` will create [spark_sql.py](spark_sql.py)
- Edit the Python script to submit Spark jobs with CLI

    `URL="spark://khai2612-Latitude-5480:7077"`

    `spark-submit \
        --master=${URL} gcs/spark_sql.py \
        --input_green=data/parquet/green/2021/*/ \
        --input_yellow=data/parquet/yellow/2021/*/ \
        --output=data/report-2021`

### Setting up a Dataproc Cluster
### Connecting Spark to BigQuery