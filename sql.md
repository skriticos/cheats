### COMMAND CHEATSHEET

- sudo -u postgres psql
- sudo -u postgres psql -E
  - show executed sql statements (for macros)
- service postgresql [start|stop|restart]
- \list
  - list databases
- \dt
  - list tables
- \connect dbname
  - connect to database

### SQL CHEEATSHEET

- CREATE DATABASE dbname;
- CREATE TABLE tableName (col1 type1, col2 type2, ..);
- SELECT * FROM tableName;
- SELECT col1, col2, .. FROM tableName WHERE col=val;
- SELECT col1, col2, .. FROM tableName ORDER BY colX DESC LIMIT 10;
- SELECT EXISTS (SELECT 1 FROM tableName WHERE col=val LIMIT 1);
- INSERT INTO tableName (col1, col2) VALUES (val1, val2);
- UPDATE tableName SET col1=val1, col2=val2 .. WHERE col=val;
- DELETE FROM tableName;
  - delete all records
- DELETE FROM tableName WHERE col=val;
- SELECT datname FROM pg\_database WHERE
- SELECT datname FROM pg\_database WHERE datistemplate=false;
  - list database names
- SELECT tableName FROM information\_schema.tables WHERE table\_schema='public'
  AND table\_type='BASE TABLE';
  - list table names of current database
- SELECT EXISTS ( SELECT * FROM information\_schema.tables WHERE table\_name =
  'tableName');
  - check if table exists in database

### SETUP USER FOR DATABASE

- CREATE USER user\_name WITH PASSWORD 'myPassword';
- ALTER DATABASE name OWNER TO new_owner;
- GRANT ALL PRIVILEGES ON DATABASE dbname TO user\_name;
