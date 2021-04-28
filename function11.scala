val df = sqlContext.sql("SELECT price as price, COUNT(closed) as OpenClosed FROM places WHERE closed = 'False' AND price LIKE '%$%' GROUP BY price")
df.show()

System.exit(0)
