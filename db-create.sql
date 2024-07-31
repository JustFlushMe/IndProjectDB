CREATE DATABASE Zinin404_logist_v1;

USE Zinin404_logist_v1;


CREATE TABLE Customers(
	cu_id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	cu_type varchar(30) NOT NULL,
	cu_name varchar(90) NOT NULL,
	cu_PSRN varchar(13) NOT NULL,
	cu_mail varchar(254) NOT NULL,
	cu_phone varchar(12) NOT NULL,
	cu_dateOfReg date NOT NULL
);

CREATE TABLE Layers(
	lay_id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	lay_localnumb varchar(4) NOT NULL,
	lay_name varchar(90) NOT NULL,
	lay_phone varchar(11) NOT NULL,
	lay_email varchar(254) NOT NULL
);

CREATE TABLE Agents(
	ag_id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	ag_localnumb varchar(4) NOT NULL,
	ag_name varchar(90) NOT NULL,
	ag_phone varchar(11) NOT NULL,
	ag_email varchar(254) NOT NULL
);

CREATE TABLE Cargoes(
	ca_id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	ca_name varchar(60) NOT NULL,
	ca_type varchar(60) NOT NULL,
	ca_weight decimal(8, 3) NOT NULL,
	ca_specifics varchar(90),
	ca_cust int NOT NULL,

	FOREIGN KEY (ca_cust) REFERENCES Customers(cu_id)
);

CREATE TABLE Agreements(
	agr_id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	agr_customer int NOT NULL,
	agr_status varchar(8) NOT NULL,
	agr_localnumb varchar(8) NOT NULL,
	agr_dateS date NOT NULL,
	agr_dateE date NOT NULL,
	agr_layer int NOT NULL,
	agr_agent int NOT NULL,

	FOREIGN KEY (agr_customer) REFERENCES Customers(cu_id),
	FOREIGN KEY (agr_layer) REFERENCES Layers(lay_id),
	FOREIGN KEY (agr_agent) REFERENCES Agents(ag_id)
);

CREATE TABLE Payments(
	pay_id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	pay_agr int NOT NULL,
	pay_datetime datetime NOT NULL,
	pay_wroffacc varchar(20) NOT NULL,
	pay_enrollacc varchar(20) NOT NULL,
	pay_sum float NOT NULL,
	pay_status varchar(30) NOT NULL,

	FOREIGN KEY (pay_agr) REFERENCES Agreements(agr_id)
);

CREATE TABLE Cancels(
	can_id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	can_agr int NOT NULL,
	can_reason varchar(90) NOT NULL,
	can_date date NOT NULL,

	FOREIGN KEY (can_agr) REFERENCES Agreements(agr_id)
);

CREATE TABLE Drivers(
	dr_id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	dr_localnumb varchar(4) NOT NULL,
	dr_name varchar(90) NOT NULL,
	dr_license varchar(3) NOT NULL
);


CREATE TABLE Logisticians(
	log_id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	log_localnumb varchar(4) NOT NULL,
	log_name varchar(90) NOT NULL,
	log_phone varchar(11) NOT NULL,
	log_email varchar(254)
);



CREATE TABLE Vehicles(
	veh_id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	veh_type varchar(60) NOT NULL,
	veh_model varchar(60) NOT NULL,
	veh_carrcap float NOT NULL,
	veh_geolocation numeric(5,2) NOT NULL,
	veh_status varchar(30) NOT NULL
);

CREATE TABLE Routes(
	rou_id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	rou_agr int NOT NULL,
	rou_vehicle int not null,
	rou_driver int NOT NULL,
	rou_startGeo numeric(5,2) NOT NULL,
	rou_finishGeo numeric(5,2) NOT NULL,
	rou_status varchar(3) NOT NULL,
	rou_details varchar(300),
	rou_author int NOT NULL,

	FOREIGN KEY (rou_agr) REFERENCES Agreements(agr_id),
	FOREIGN KEY (rou_vehicle) REFERENCES Vehicles(veh_id),
	FOREIGN KEY (rou_driver) REFERENCES Drivers(dr_id),
	FOREIGN KEY (rou_author) REFERENCES Logisticians(log_id)
);