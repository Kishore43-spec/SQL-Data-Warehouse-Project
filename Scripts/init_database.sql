
/*

===================================================
Create Database and Schemas
===================================================

Script Purpose:
The script create a new database  named 'datawarehouse' after checking if it already exits.
If the database exists, it is dropped and recreated. Additionally, the script sets up three Schemas 
with the database: 'bronze, sliver, gold

Warning:
Running this script will drop the entire 'Datawarehouse' database if it exists.
All data in the database will be permanently deleted. Proceed with caution and ensure you have 
proper backups before running the scripts

*/



use master
go

--drop and recreate the 'datawarehouse' database

if exists( select 1 from sys.databases where name = 'datawarehouse')
begin
alter database datawarehouse 
set single_user with rollback immediate;

drop database datawarehouse;

end 

--create the database 'datawarehouse'
create database datawarehouse

use datawarehouse

--create the schemas

create schema bronze
go
create schema sliver
go
create schema gold
go

