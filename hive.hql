create table categories2(category_id int, category_department_id int, category_name String, t timestamp);
insert into table categories2 select *, from_unixtime(unix_timestamp()) from categories;