#!/bin/bash
sqoop import-all-tables --connect jdbc:mysql://localhost:3306/retail_db --username retail_dba --password cloudera --warehouse-dir /user/cloudera/retail_stage.db --as-avrodatafile --compress --compression-codec snappy
