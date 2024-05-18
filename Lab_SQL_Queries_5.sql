## Lab | SQL Queries 5
## In this lab, you will be using the Sakila database of movie rentals.

use sakila; ## Use the database sakila 

## Drop column picture from staff.

select * from staff;

alter table staff		##  ALTER TABLE statement is used to add, delete, or modify columns in an existing table.
	drop column picture;
        
select * from staff; ## this table shows only two staffs (Jon and Mike) 

## A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

select * from customer;

select * from customer where last_name = "Sanders";
	INSERT INTO staff (first_name, last_name, email, address_id, store_id, active, username, password, last_update)		## INSERT INTO statement is used to insert new records in a table. https://www.w3schools.com/sql/sql_insert.asp
		VALUES ('Tammy', 'Sanders', 'tammy.sanders@example.com', 79, 1, 1, 'tammy_sanders', 'password', NOW());

select * from staff; ## table staff is updated now and it countains 3 staffs (Jon, Mike, and Tammy Sanders) 

## Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
	## select customer_id from sakila.customer
	## where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
	## Use similar method to get inventory_id, film_id, and staff_id.

select * from rental;
select count(*) from rental; ## there are 16044 rental ids

select * from customer;

select * from customer where first_name = "CHARLOTTE"; 	## customer_id 130
select * from customer where last_name = "HUNTER"; 	## customer_id 130

select * from film where title = "Academy Dinosaur";  ## film_id 1

select * from inventory where film_id = "1"; ## inventory_id 1

select * from staff where last_name = "Hillyer"; ## staff_id 1

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)  ## https://www.w3schools.com/sql/sql_insert.asp
VALUES (NOW(), 1, 130, NULL, 1);

## Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
	## Check if there are any non-active users
	## Create a table backup table as suggested
	## Insert the non active users in the table backup table
	## Delete the non active users from the table customer
    
select * from customer;
select count(*) from customer; ## total of 599 users listed on the table customer
select distinct (active) from customer; ## customers are classifiers as active or not (1 or 0)

select count(*)
	from customer
		where active = "0";  ## there are 15 customers not active (column "active" indicating "0")

select *
    from customer
		where active = "0";  ## there are 15 customers not active (column "active" indicating "0")
        
create table backup_table_deleted_users (
    backup_table_deleted_users int auto_increment PRIMARY KEY,
    customer_id int,
    email varchar(255),  ## VARCHAR(size)  VARIABLE length string (can contain letters, numbers, and special characters). The size parameter specifies the maximum string length in characters - can be from 0 to 65535. # https://www.w3schools.com/sql/sql_datatypes.asp
    deletion_date timestamp default current_timestamp
);

insert into backup_table_deleted_users (customer_id, email)
	select customer_id, email
		from customer
			where active = "0";
            
select * from backup_table_deleted_users;  ## 15 not active customers were stored to the this new table backup_table_deleted_users

delete from customer
	where active = 0;  
    
select count(active) 
	from customer 
		where active = 0;