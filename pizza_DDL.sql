CREATE DATABASE pizza;
USE pizza;

CREATE TABLE items(
	ingredient varchar(15) CONSTRAINT items_PK PRIMARY KEY,
	type varchar(8)
	);

CREATE TABLE menu(
	pizza varchar(30) CONSTRAINT menu_PK PRIMARY KEY,
	price dec(4,2),
	country varchar(20),
	base varchar(20)
	);

CREATE TABLE recipe(
	pizza varchar(30) FOREIGN KEY REFERENCES menu(pizza),
	ingredient varchar(15) FOREIGN KEY REFERENCES items(ingredient),
	amount int
	);