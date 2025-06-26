# library
import argparse, os, sys
from time import time
import pandas as pd
import pyarrow.parquet as pq
from sqlalchemy import create_engine


def main(params):

    # values of parameters
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    tb = params.tb
    url = params.url

    # database engine
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    # take only filename part in the url 
    filename = url.rsplit('/', 1)[-1].strip()
    print(f'Downloading {filename} ...')
    # execute the command in a subshell (download data from url & write to a given file)
    os.system(f"wget -O {filename} {url.strip()}")

    # reading file (csv or parquet)
    # if is csv file, using pandas
    if ".csv" in filename:
        df = pd.read_csv(filename, nrows=10)
        df_iter = pd.read_csv(filename, iterator=True, chunksize=100000)
    # if is parquet file, using pyarrow
    elif '.parquet' in filename:
        file = pq.ParquetFile(filename)
        df = next(file.iter_batches(batch_size=10)).to_pandas()
        df_iter = file.iter_batches(batch_size=100000)
    else:
        print('Error. Only csv or parquet files allowed.')
        sys.exit()

    # create a new table in database with only column names
    # head(n=0) is the name of columns
    df.head(n=0).to_sql(name=tb, con=engine, if_exists='replace')

    # loop over each chunk (if csv) or batch (if parquet) and insert data into database
    # calculate time for each operation
    t_start = time()
    count = 0 # count the number of times the batch is put into the database
    for batch in df_iter:

        count += 1

        # convert batch to DataFrame
        if '.parquet' in filename:
            batch_df = batch.to_pandas()
        else:
            batch_df = batch

        print(f'Inserting batch {count}...')

        # insert data
        b_start = time()
        batch_df.to_sql(name=tb, con=engine, if_exists='append')
        b_end = time()

        print(f'Inserted! Time taken {b_end - b_start:10.3f} seconds.\n')

    # finish inserting
    t_end = time()   
    print(f'Completed! Total time taken was {t_end - t_start:10.3f} seconds for {count} batches.')


if __name__ == '__main__':

    # entry point
    # parse command-line arguments and give the main() function
    # ex: python ingest_data.py --user=root ...
    parser = argparse.ArgumentParser(description='Ingest data to Postgres')

    parser.add_argument('--user', help='Username for Postgres')
    parser.add_argument('--password', help='Password for Postgres') 
    parser.add_argument('--host', help='Hostname for Postgres')  
    parser.add_argument('--port', help='Port for Postgres connection')  
    parser.add_argument('--db', help='Database name')  
    parser.add_argument('--tb', help='Table name')
    parser.add_argument('--url', help='Url of csv file') 

    args = parser.parse_args()

    main(args)