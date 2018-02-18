#! /bin/bash
sqoop import --connect jdbc:mysql://localhost:3306/retail_db \
      --username retail_dba --password cloudera \
      --target-dir /user/cloudera/problem1/order_items \
      --compression-codec snappy --as-avrodatafile --table order_items

