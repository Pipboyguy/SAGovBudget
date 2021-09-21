# 🇿🇦South African Treasury Dashboard 💸🔥
==============================


A dashboard based on SA government's expenditure, as reported by the [national treasury](http://www.treasury.gov.za/statistics/Quarterly%20spending%20data/2020/), all built with open source software with permissive licenses.

![dashboard-pic](assets/dashboard-pic.png?raw=true)

## Setup

This code should work on most operating systems. Do note that certain steps require a shell script to be executed, and so if you are on windows you might need to use something like Windows Subsystem for Linux.

### Steps:
#### Get the code
1. Make sure you have Docker and Git installed on your computer. Because apache superset has heavy resource requirements, make sure you have at least 8GB of RAM to the virtual machine like so:<br><bt>![ =100x20](assets/docker-resources.png?raw=true)

3. Clone this repository **along with the submodules** by running:
```shell
git clone --recurse-submodules https://github.com/Pipboyguy/SAGovBudget.git
```

#### Download the data and run ETL
3. In the project's root folder, run:
```shell
sh create-sqlitedb.sh
```
this will download the needed images, and run the ETL notebook found in `notebooks/CollateData.ipynb`. You can view the output and logs of this notebook by opening up `notebooks/CollateData-OUTPUT.ipynb` with a jupyter notebook viewer.
Please note that this can take up to 15 Minutes to download all files, extract the CSV files, and convert to a SQLite database, depending on your internet speed.

#### Spin up superset dashboard
4. Navigate to the `superset/` folder and run:
```shell
docker-compose -f docker-compose-non-dev.yml up
```
After some time, your should be able to open http://localhost:8088/ in your browser and be connected to apache superset. If you are prompted for a username and password, its just "**admin**".

5. We need to import our SQLite database that we generated in the ETL process earlier.
Go to  *Data -> Databases -> '+ Database'*.<br>Choose SQLite as a database type, name your database `treasurydb` and fill the URI as`sqlite:////treasury-data/SAGovBudget.sqlite`<br><br>![connet-to-db-pic](assets/howto-connect-to-db.png?raw=true)
<br><br>Test your connection. If successful, press *Connect*.
:sunglasses:**Daaashboading time!!**:sunglasses:

6. You can either build your own corrupt dashboard from here, or import the starter dashboard located in `src/visualization/treasury-dashboard-starter.json`.<br><br>To Import the dashboard, in superset navigate to *Settings -> Import dashboards*. From here, choose `treasury-dashboard-starter.json` and your database as *treasurydb*:<br><br>![import-dashboard](assets/import-dashboard-pic.png?raw=true).<br><br>You should find the started dashboard at *Dashboards* Tab.

Finally, you should be off to the races! :horse:

## Call for Participation

It goes without saying that if you like tech, finance, data processing and visualizing financial information using code, this is an ideal project to contribute towards. Also, just because it is south african data, doesn't mean we can't start integrating other countries' information as well.

Feel free to fork and contribute!!

## Some Notes

### Modifications to Apache Superset
Apache Superset users SQLite database. Since they plan on dropping support for SQLite, a temporary workaround is to set the flag `PREVENT_UNSAFE_DB_CONNECTIONS = False` (https://github.com/apache/superset/issues/9748) by editing `superset_config.py`



This is why there is a submodule in this repo, to apply these amendments. The submodule already contains
these amendments.
