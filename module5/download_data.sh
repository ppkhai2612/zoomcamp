# DOWNLOAD A FILE FROM URL AND SAVE IT INTO LOCAL FILE SYSTEM (parquet files)

# script immediately shall exit when encounter any error
set -e

# user gives 2 arguments
# ex: ./download_data.sh yellow 2020
TAXI_TYPE=$1
YEAR=$2

URL_PREFIX='https://d37ci6vzurychx.cloudfront.net/trip-data'

# iterate from 1 to 12
for MONTH in {1..12};
do

    # https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2020-01.parquet
    FMONTH=$(printf "%02d" ${MONTH}) # ex: 01, 02,..    
    URL="${URL_PREFIX}/${TAXI_TYPE}_tripdata_${YEAR}-${FMONTH}.parquet"

    # download a file from URL and save it into local file system
    LOCAL_PREFIX="data/parquet_raw/${TAXI_TYPE}/${YEAR}/${FMONTH}"
    LOCAL_FILE="${TAXI_TYPE}_tripdata_${YEAR}-${FMONTH}.parquet"
    LOCAL_PATH="${LOCAL_PREFIX}/${LOCAL_FILE}"

    mkdir -p ${LOCAL_PREFIX}
    echo "downloading ${URL} to ${LOCAL_PATH}"
    wget ${URL} -O ${LOCAL_PATH}

done