# Data Ingestion

Data Ingestion: is the process of extracting data from a source, transporting it to a suitable environment, and preparing it for use. This often includes normalizing, cleaning, and adding metadata

dlt (data load tool): an open-source Python library that loads data from various, often messy data sources into well-structured, live datasets - data ingestion (installed with `pip install dlt`)

Google Colab: is a hosted Jupyter Notebook service that requires no setup to use and provides free access to computing resources. Colab is especially well suited to machine learning, data science, and education (`google.colab` is built-in)

Data Ingestion includes 3 main stages:

### Extracting Data

Most of the data you’ll work with is stored behind an RESTful API (File-based APIs, Database APIs). Some common challenges:

- Rate limits: many APIs limit the number of requests you can make within a certain time frame to prevent overloading their servers
- Authentication: many APIs require an API key or token to access data securely
- Pagination: many APIs return data in chunks (or pages) rather than sending everything at once => to retrieve all the data, we need to make multiple requests and keep track of pages until we reach the last one
- Memory Management: many pipelines run on systems with limited memory => load all the data into memory at once, it can crash the entire system

Code: [extract_data.ipynb](extract_data.ipynb)

### Normalizing Data

Two key steps:

- Normalizing data: Structuring and standardizing data without changing its meaning
- Filtering data for a specific use case: selecting or modifying data in a way that changes its meaning to fit the analysis

Code: [normalize_data.ipynb](normalize_data.ipynb)

### Loading Data

Incremental Loading: update datasets by loading only new or changed data, instead of replacing the entire dataset, two methods:

- Append (adding new records) - use for immutable or stateless data
- Merge (updating existing records) - use for stateful data

In addition, can load data into cloud as BigQuery, GCS,... for production purposes

Code: [load_data.ipynb](load_data.ipynb)

*Note: all codes in workshop must be run on Google Colab*