# Batch Processing (Spark)

### Introduction

- Batch vs Streaming Processing. https://phuockhai.notion.site/Batch-streaming-processing-2221e0bbbf3980d48606cde1c4432fbf
- Spark: https://phuockhai.notion.site/Apache-Spark-1bd1e0bbbf3980649b9edd9377dee354?pvs=74

### Installation

There are 2 ways
- Locally
    - Install Spark on Linux: https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/05-batch/setup/linux.md
    - PySpark: https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/05-batch/setup/pyspark.md

    *Need to install 3 things: JDK, Spark, Python*

    *Note: best practice is should save env vars in .bashsrc file, so don't need to export for every bash session*
- Cloud: Databricks, Google Colab

### Spark SQL and DataFrames

Code: [test.ipynb](test/test.ipynb)

**Reading and Writing**

When running a Spark job successfully, Spark always create a folder that include necessary files
- Files containing the data to be written (divided into partitions). Ex: *part-NNNNN-XXXXXXXX-YYYY-ZZZZ.extension*
- *.crc (Cyclic Redundancy Check)* files: used to ensure data integrity when reading and writing files
- *_SUCCESS* files: created only when all Spark jobs run successfully

**Transformation & Action**: https://phuockhai.notion.site/Transformation-Action-2231e0bbbf3980fd83aee9a17277e81c

**Spark SQL**

- Run [download_data.sh](download_data.sh) to download Parquet raw file from URL

- Then, run [modify_schema.ipynb](modify_schema.ipynb)
    - Modify schema from Parquet raw files
    - Write new results out

- Experience with Spark SQL via [spark_sql.ipynb](spark_sql.ipynb)

### Spark Internals

**Spark Architecture**: https://phuockhai.notion.site/Spark-Architecture-2241e0bbbf3980bebc40e67e7cfd252e

**GroupBy and Joins in Spark**

Narrow & Wide transformation: https://phuockhai.notion.site/Narrow-Wide-transformation-2241e0bbbf3980fcbc78f0fe2c6b867b?pvs=74

*Groupby & Join are wide tranformations that cause shuffling process -> negative impact on performance due to having to move data between nodes*

*One of the solutions is broadcast variables allow the programmer to keep a read-only variable cached on each machine rather than shipping a copy of it with tasks*

Code: [groupby.ipynb](groupby.ipynb) & [join.ipynb](join.ipynb)

### Resilient Distributed Datasets (RDDs)

### Running Spark in the Cloud

Instructions at [cloud.md](gcs/cloud.md)