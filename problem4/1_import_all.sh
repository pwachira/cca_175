#! /bin/bash
sqoop import --connect jdbc:mysql://quickstart.cloudera:3306/retail_db \
    --table orders --username retail_dba --password cloudera \
    --as-textfile --target-dir /user/cloudera/problem5/text \
    --fields-terminated-by \t --lines-terminated-by \n ;

sqoop import --connect jdbc:mysql://quickstart.cloudera:3306/retail_db \
    --table orders --username retail_dba --password cloudera \
    --as-avrodatafile --target-dir /user/cloudera/problem5/avro ;

sqoop import --connect jdbc:mysql://quickstart.cloudera:3306/retail_db \
    --table orders --username retail_dba --password cloudera \
    --as-parquetfile --target-dir /user/cloudera/problem5/parquet ;
