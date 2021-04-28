sqlContext.sql("CREATE TABLE IF NOT EXISTS places(gplusplaceid STRING, name STRING, price STRING, address STRING, hours STRING, phone STRING, closed STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TextFile")

sqlContext("LOAD DATA INPATH 'hdfs://quickstart.cloudera/user/cloudera/places.csv' OVERWRITE INTO TABLE places")

val df = sqlContext.sql("SELECT price as price, COUNT(closed) as OpenClosed FROM places WHERE closed = 'False' AND price LIKE '%$%' GROUP BY price")
df.show()

System.exit(0)
