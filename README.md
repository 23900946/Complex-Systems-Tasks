# CompexSystemCwk2System
Before running this program, please make sure that the required datasets are uploaded to Hive.

To Run program either open the folder inside the terminal and type the command ./functionalityScript.sh or use file viewer and select the file functionalityScript.sh and run in terminal.

If a table for reviews and places hasn't been uploaded previously, Please put the Reviews and Places dataset into HDFS /user/cloudera and run use the command:
sudo spark-shell SparkUploadDB.scala

This will create the tables needed to run the spark functions within the system
