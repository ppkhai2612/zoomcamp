# Python image
FROM python:3.9.1

# install library
RUN pip install pandas

# change working directory
WORKDIR /app

# copy files/directories
COPY pipeline.py pipeline.py

# run python on the python script
ENTRYPOINT [ "python", "pipeline.py" ]