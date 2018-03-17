alter table orders_sqoop set tblproperties (
'avro.schema.literal' = '{
  "type" : "record",
  "name" : "orders",
  "doc" : "Sqoop import of orders",
  "fields" : [ {
    "name" : "order_id",
    "type" : [ "null", "int" ],
    "default" : null,
    "columnName" : "order_id",
    "sqlType" : "4"
  }, {
    "name" : "order_date",
    "type" : [ "null", "long" ],
    "default" : null,
    "columnName" : "order_date",
    "sqlType" : "93"
  }, {
    "name" : "order_customer_id",
    "type" : [ "null", "int" ],
    "default" : null,
    "columnName" : "order_customer_id",
    "sqlType" : "4"
  }, {
    "name" : "order_status",
    "type" : [ "null", "string" ],
    "default" : null,
    "columnName" : "order_status",
    "sqlType" : "12"
  },
{
    "name" : "order_style",
    "type" : [ "null", "string" ],
    "default" : null,
    "columnName" : "order_style",
    "sqlType" : "12"
  },
{
    "name" : "orders_zone",
    "type" : [ "null", "int" ],
    "default" : null,
    "columnName" : "order_zone",
    "sqlType" : "4"
  }
],
  "tableName" : "orders"
}'
);
