sqoop list-databases --connect "jdbc:mysql://quickstart" --username root --password cloudera
echo "Enter the database you want to invoke"
read db
echo "database invoked"
sqoop list-tables --connect jdbc:mysql://quickstart/$db --username root --password cloudera
echo "Enter the table u want to import in hive from RDBMS"
read iht
sqoop import --connect jdbc:mysql://quickstart/$db --username root -P --table $iht --hive-import -m 1
echo "table import complete"
echo "Enter the folder  for avro file"
read avfile
sqoop import --connect jdbc:mysql://quickstart/$db --username root -P --table $iht --as-avrodatafile --target-dir /user/cloudera/HiveData/$avfile
hdfs dfs -ls /user/cloudera/HiveData/$avfile
echo "Enter the avro file to be converted to .avsc"
read afile
hdfs dfs -cat /user/cloudera/HiveData/$avfile/$afile
mkdir avro
cd avro
hdfs dfs -ls /user/cloudera/HiveData
hadoop fs -get /user/cloudera/HiveData/$avfile
cd $avfile
ls -l
echo "Enter the same data as the original file in sql db using vi or gedit and stor it as text file"