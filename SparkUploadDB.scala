sqlContext.sql("CREATE TABLE IF NOT EXISTS places(gplusplaceid STRING, name STRING, price STRING, address STRING, hours STRING, phone STRING, closed STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TextFile")

sqlContext("LOAD DATA INPATH 'hdfs://quickstart.cloudera/user/cloudera/places.csv' OVERWRITE INTO TABLE places")

sqlContext.sql("CREATE TABLE IF NOT EXISTS reviews(gplusplaceid STRING, gplususerid STRING, rating STRING, reviewername STRING, reviewtext STRING, categories STRING, reviewtime STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TextFile")

sqlContext.sql("LOAD DATA INPATH 'hdfs://quickstart.cloudera/user/cloudera/reviews.csv' OVERWRITE INTO TABLE reviews")

system.exit(0)
