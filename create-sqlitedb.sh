#!/bin/sh

### build and run notebook to create SQLite DB ###

# build ETL notebook image
docker build -t govnotebook -f govnotebook.dockerfile . 
# start container in background
docker run  --name govnb -d -v `pwd`:/home/jovyan/work govnotebook
# run papermill notebook pipeline
docker exec govnb papermill /home/jovyan/work/notebooks/CollateData.ipynb \
	/home/jovyan/work/notebooks/CollateData-OUTPUT.ipynb
# cleanup container
docker container rm -fv govnb 
