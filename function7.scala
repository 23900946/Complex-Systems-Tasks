val df = sqlContext.sql("select * from places")
val newDF = df.groupBy("closed").count
newDF.show()
