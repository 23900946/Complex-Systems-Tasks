val df = sqlContext.sql("SELECT gplusplaceid AS placeid, gplususerid AS userid, reviewtext FROM reviews")

df.show(false)

val numrows = df.count()

df.repartition(numrows.toInt).rdd.saveAsTextFile("hdfs://quickstart.cloudera/user/cloudera/reviewtext")

System.exit(0)
