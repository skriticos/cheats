### COMMAND CHEATSHEET

- command sql line (shell): **sudo -u postgres psql**
- show which queries are executed by macros (shell): **sudo -u postgres psql -E**
- service (shell): **service postgresql [start|stop|restart]**
- list databases (psql): **\list**
- list tables (psql): **\dt**
- select database (psql): **\connect dbname**

### SQL CHEEATSHEET

- create database: **CREATE DATABASE dbname;**
- create table: **CREATE TABLE table_name (column1 type1, column2 type2, ..);**
- show all columns of all records: **SELECT * FROM table_name;**
- show specific column of all records: **SELECT column1, column2, .. FROM table_name;**
- show specific record: **SELECT column1, column2, .. FROM table_name WHERE columnX=valueX;**
- limited query after sort: **SELECT columns FROM table_name ORDER BY column DESC LIMIT 10;**
- check if record with columnvalue exists: **SELECT EXISTS (SELECT 1 FROM table_name WHERE column=value LIMIT 1);**
- insert record into database: **INSERT INTO table_name (column1, column2, ..) VALUES (value1, value2, ..);**
- update a value in a row: **UPDATE table_name SET column1=value1, column2=value2, .. WHERE columnX=valueX;**
- delete all rows in a table: **DELETE FROM table_name;**
- delete a specific table row: **DELETE FROM table_name WHERE column1=value1;**
- list database names: **SELECT datname FROM pg_database WHERE datistemplate = false;**
- list table names of current database (sql way): **SELECT table_name  FROM information_schema.tables  WHERE table_schema='public' AND table_type='BASE TABLE';**
- check if table exists in database: **SELECT EXISTS ( SELECT * FROM information_schema.tables WHERE table_name = 'table_name');**

### SETUP USER FOR DATABASE

- CREATE USER user_name WITH PASSWORD 'myPassword';
- GRANT ALL PRIVILEGES ON DATABASE dbname TO user_name;
