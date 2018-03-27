create external table orders_sqoop
STORED AS AVRO
location '/user/cloudera/retail_stage.db/orders'
TBLPROPERTIES ('avro.schema.url'='file:///home/cloudera/cca_175/problem3/orders.avsc');
