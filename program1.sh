echo "Enter the table pesent in Desktop"
read a
hdfs dfs -put /home/cloudera/Desktop/databases/$a /user/cloudera/HiveData
echo "Table inserted in hive"
hdfs dfs -ls /user/cloudera/HiveData
echo "(load data inpath '/user/cloudera/HiveData/new.csv' overwrite into table Distributer;):-enter this command in hive shell"
