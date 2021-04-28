val df = sqlContext.sql("select * from places")
val newDF = df.groupBy("price").count
newDF.show()
 
