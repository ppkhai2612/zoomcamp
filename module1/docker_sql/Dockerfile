# Python image
FROM python:3.9.1

# install library
RUN apt-get install wget curl
RUN pip install pandas sqlalchemy psycopg2 pyarrow

# Set working directory
WORKDIR /app

# Copy pipeline.py into the container
COPY ingest_data.py ingest_data.py

# specify run python for python script
ENTRYPOINT [ "python", "ingest_data.py" ]