Hive Scripts for loading batting data set:

create database case_ipl;

use case_ipl;

show tables;

create table batting (id int, name String, runs int, high_score int, average float, strike_rate float, sixes int) partitioned by (team String) row format delimited fields terminated by ',' stored as textfile;

describe batting;
load data local inpath '/home/training/Desktop/HIvePracticedata/cityWiseData/Bangalore.csv'
overwrite into table batting
partition (team = 'Bangalore');
load data local inpath '/home/training/Desktop/HIvePracticedata/cityWiseData/Chennai.csv'
overwrite into table batting
partition (team = 'Chennai');
load data local inpath '/home/training/Desktop/HIvePracticedata/cityWiseData/Delhi.csv'
overwrite into table batting
partition (team = 'Delhi');
load data local inpath '/home/training/Desktop/HIvePracticedata/cityWiseData/Hyderabad.csv'
overwrite into table batting
partition (team = 'Hyderabad');
load data local inpath '/home/training/Desktop/HIvePracticedata/cityWiseData/Kolkata.csv'
overwrite into table batting
partition (team = 'Kolkata');



select * from batting;

Problem with above method is that it becomes cumbersome with too many partitions

Dynamic Partitions for bowling data set

create table bowling_no_partition
(id int, name String, team String, overs float, runs int, wickets int, avg float, economy float, strike_rate float)
row format delimited
fields terminated by ','
stored as textfile;

hdfs dfs -mkdir /user/training/HiveData

hdfs dfs -put /home/training/Desktop/HIvePracticedata/Bowling.csv /user/training/HiveData

hdfs dfs -ls /user/training/HiveData

load data inpath '/user/training/HiveData/Bowling.csv' overwrite into table bowling_no_partition;

create table bowling
(id int, name String, overs float, runs int, wickets int, avg float, economy float, strike_rate float)
partitioned by (team String)
row format delimited
fields terminated by ','
stored as textfile;

set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.dynamic.partition=true;

insert overwrite table bowling
partition (team)
select bl.id, bl.name, bl.overs, bl.runs, bl.wickets, bl.avg, bl.economy, bl.strike_rate, bl.team
from bowling_no_partition bl;

drop table bowling_no_partition;
=======================================

Creating an external table

create external table bowling_no_partition_external
(id int, name String, team String, overs float, runs int, wickets int, avg float, economy float, strike_rate float)
row format delimited
fields terminated by ','
stored as textfile location '/user/training/MyExtTable';

hdfs dfs -put /home/training/Desktop/HIvePracticedata/Bowling.csv /user/training/MyExtTable