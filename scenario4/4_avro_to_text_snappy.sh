#! /bin/bash
sqoop import --connect jdbc:mysql://localhost:3306/retail_db --username retail_dba --password cloudera \
    --table orders --as-textfile --compress --compression-codec snappy \
    --target-dir /user/cloudera/problem5/text-snappy-compress
