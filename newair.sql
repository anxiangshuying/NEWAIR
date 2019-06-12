#数据库newair
DROP DATABASE IF EXISTS newair;
CREATE DATABASE newair CHARACTER SET utf8;
USE newair;

#用户表1
DROP TABLE IF EXISTS user;
CREATE TABLE user (
	user_id varchar(50) PRIMARY KEY,
	user_password varchar(32) NOT NULL,
	user_lname_ch varchar(20) NOT NULL,
	user_fname_ch varchar(20) NOT NULL,
	user_lname_en varchar(20) NOT NULL,
	user_fname_en varchar(20) NOT NULL,
	user_gender enum('F','M') NOT NULL,
	user_birthdate date NOT NULL,
	user_certif_type enum('I','G','P') NOT NULL,
	user_certif_no varchar(18) NOT NULL,
	user_phone varchar(11) NOT NULL,
	user_email varchar(50) NOT NULL,
	user_zipcode varchar(6) NOT NULL,
	user_address varchar(100) NOT NULL,
	user_married varchar(1),
	user_company_name varchar(50),
	user_job varchar(20),
	user_company_phone varchar(12),
	user_company_fax varchar(12)
) ENGINE=InnoDB;

#乘机人表2
DROP TABLE IF EXISTS passenger;
CREATE TABLE passenger (
	psg_id varchar(50) PRIMARY KEY,
	psg_name varchar(20) NOT NULL,
	psg_phone varchar(11) NOT NULL,
	psg_certif_type enum('I','G','P') NOT NULL,
	psg_certif_no varchar(18) NOT NULL,
	psg_type enum('A','C','I') NOT NULL,
	psg_add_date date NOT NULL,
	psg_status enum('A','U') default 'A' NOT NULL,
	ref_user_id varchar(50) NOT NULL
) ENGINE=InnoDB;

#银行卡表3
DROP TABLE IF EXISTS bank;
CREATE TABLE bank (
	bank_id int(3) PRIMARY KEY AUTO_INCREMENT,
	bank_name varchar(50) NOT NULL
) ENGINE=InnoDB;

#银行卡号表4
DROP TABLE IF EXISTS bankcard;
CREATE TABLE bankcard (
	bankcard_id int(6) PRIMARY KEY AUTO_INCREMENT,
	bankcard_no varchar(20) NOT NULL,
	bankcard_validate varchar(3) NOT NULL,
	bankcard_certif_type char(1) NOT NULL,
	bankcard_certif_no varchar(18) NOT NULL,
	bankcard_phone varchar(11) NOT NULL,
	bankcard_email varchar(50),
	ref_bank_id int(3) NOT NULL
) ENGINE=InnoDB;

#省份表5
DROP TABLE IF EXISTS province;
CREATE TABLE province (
	province_id int(2) PRIMARY KEY AUTO_INCREMENT,
	province_name varchar(20) NOT NULL UNIQUE,
	province_simple_name varchar(10) NOT NULL UNIQUE,
	province_spell_name varchar(20) NOT NULL
) ENGINE=InnoDB;

#城市表6
DROP TABLE IF EXISTS city;
CREATE TABLE city (
	city_id int(3) PRIMARY KEY AUTO_INCREMENT,
	city_name varchar(20) NOT NULL UNIQUE,
	city_spell_name varchar(20) NOT NULL,
	ref_province_id int(2) NOT NULL
) ENGINE=InnoDB;

#营业网点表7
DROP TABLE IF EXISTS branch;
CREATE TABLE branch (
	branch_id int(3) PRIMARY KEY AUTO_INCREMENT,
	branch_name varchar(20) NOT NULL UNIQUE,
	branch_telephone1 varchar(20),
	branch_telephone2 varchar(20),
	branch_fax varchar(20),
	branch_address varchar(200),
	branch_state enum('O','C') default 'O' NOT NULL,
	ref_province_id int(2) NOT NULL,
	ref_city_id int(3) NOT NULL
) ENGINE=InnoDB;

#机场表8
DROP TABLE IF EXISTS airport;
CREATE TABLE airport (
	airport_id int(3) PRIMARY KEY AUTO_INCREMENT,
	airport_name varchar(20),
	airport_full_name varchar(20) NOT NULL,
	airport_code char(3) NOT NULL UNIQUE,
	ref_province_id int(2) NOT NULL,
	ref_city_id int(3) NOT NULL
) ENGINE=InnoDB;

#航线表9
DROP TABLE IF EXISTS route;
CREATE TABLE route (
	route_id int(3) PRIMARY KEY AUTO_INCREMENT,
	from_airport_id int(3) NOT NULL,
	to_airport_id int(3) NOT NULL,
	route_distance decimal(10,2) NOT NULL,
	route_base_price decimal(10,2) NOT NULL,
	UNIQUE (from_airport_id, to_airport_id)
) ENGINE=InnoDB;

#飞机表10
DROP TABLE IF EXISTS plane;
CREATE TABLE plane (
	plane_id int(2) PRIMARY KEY AUTO_INCREMENT,
	plane_no varchar(10) NOT NULL UNIQUE,
	plane_model varchar(10) NOT NULL,
	plane_manufacturer varchar(40),
	f_cabin_seats int(3) NOT NULL,
	b_cabin_seats int(3) NOT NULL,
	e_cabin_seats int(3) NOT NULL
) ENGINE=InnoDB;

#资讯类型表11
DROP TABLE IF EXISTS news_type;
CREATE TABLE news_type (
	news_type_id int(11) PRIMARY KEY AUTO_INCREMENT,
	news_type_name varchar(50) NOT NULL
) ENGINE=InnoDB;

#资讯表12
DROP TABLE IF EXISTS news;
CREATE TABLE news (
	news_id int(11) PRIMARY KEY AUTO_INCREMENT,
	news_title varchar(100) NOT NULL,
	news_content text,
	news_create_time timestamp NOT NULL,
	ref_news_type_id int(11) NOT NULL
) ENGINE=InnoDB;

#联系人表13
DROP TABLE IF EXISTS contact;
CREATE TABLE contact (
	contact_id varchar(50) PRIMARY KEY,
	contact_name varchar(20) NOT NULL,
	contact_phone varchar(11) NOT NULL,
	contact_email varchar(50)
) ENGINE=InnoDB;

#航班表14
DROP TABLE IF EXISTS flight;
CREATE TABLE flight (
	flight_id int(6) PRIMARY KEY AUTO_INCREMENT,
	flight_no varchar(10) NOT NULL,
	flight_departure_date date NOT NULL,
	flight_departure_time timestamp NOT NULL,
	flight_arrival_date date NOT NULL,
	flight_arrival_time timestamp NOT NULL,
	flight_full_price decimal(10,2) NOT NULL,
	flight_contruction_fee decimal(5,2) NOT NULL,
	flight_petrol_fee decimal(5,2) NOT NULL,
	ref_route_id int(3) NOT NULL,
	ref_plane_id int(2) NOT NULL
) ENGINE=InnoDB;

#航班动态表15
DROP TABLE IF EXISTS flight_schedule;
CREATE TABLE flight_schedule (
	fs_id int(6) PRIMARY KEY AUTO_INCREMENT,
	fs_departure_date date,
	fs_departure_time datetime,
	fs_arrival_date date,
	fs_arrival_time datetime,
	fs_state enum('A','P','C') NOT NULL DEFAULT 'A',
	ref_flight_id int(6) NOT NULL
) ENGINE=InnoDB;

#舱位表16
DROP TABLE IF EXISTS canbin;
CREATE TABLE cabin (
	cabin_id int(6) PRIMARY KEY AUTO_INCREMENT,
	cabin_name varchar(20) NOT NULL,
	cabin_type enum('F','B','E') NOT NULL,
	cabin_seats_remain int(3) NOT NULL,
	cabin_discount decimal(3,2) NOT NULL,
	ref_flight_id int(6) NOT NULL
) ENGINE=InnoDB;


#订单表17
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	order_id varchar(50) PRIMARY KEY,
	order_price decimal(6,2) NOT NULL,
	order_contruction_fee decimal(6,2) NOT NULL,
	order_petrol_fee decimal(6,2) NOT NULL,
	order_insurance decimal(6,2) NOT NULL,
	order_create_date date NOT NULL,
	order_create_time datetime NOT NULL,
	order_state enum('U','F','C','P') NOT NULL DEFAULT 'U',
	ref_user_id varchar(50) NOT NULL,
	ref_contact_id varchar(50) NOT NULL
) ENGINE=InnoDB;

#订单-舱位中间表18
DROP TABLE IF EXISTS order_cabin;
CREATE TABLE order_cabin (
	order_id varchar(50) NOT NULL,
	cabin_id int(6) NOT NULL
) ENGINE=InnoDB;

#订单-乘机人中间表19
DROP TABLE IF EXISTS order_passenger;
CREATE TABLE order_passenger (
	order_id varchar(50) NOT NULL,
	passenger_id varchar(50) NOT NULL
) ENGINE=InnoDB;

#机票表20
DROP TABLE IF EXISTS ticket;
CREATE TABLE ticket (
	ticket_id varchar(50) PRIMARY KEY,
	ticket_price decimal(6,2) NOT NULL,
	ticket_contruction_fee decimal(6,2) NOT NULL,
	ticket_petrol_fee decimal(6,2) NOT NULL,
	ticket_insurance decimal(6,2) NOT NULL,
	ticket_seat_no int(3),
	ref_order_id varchar(50) NOT NULL,
	ref_passenger_id varchar(50) NOT NULL
) ENGINE=InnoDB;
