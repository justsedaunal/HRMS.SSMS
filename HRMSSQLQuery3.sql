
create database HRMS
IF OBJECT_ID ('tempdb..#users') is not null
IF OBJECT_ID ('tempdb..#candidates') is not null



CREATE TABLE[dbo].[users](
	id INTEGER NOT NULL  PRIMARY KEY  IDENTITY(1, 1),
	email_address VARCHAR(320) NOT NULL,
	password VARCHAR(25) NOT NULL,
	CONSTRAINT uc_users_email_address UNIQUE (email_address)
);

CREATE TABLE [dbo].[candidates]
(
	id INTEGER NOT NULL,
	first_name VARCHAR(35) NOT NULL,
	last_name VARCHAR(35) NOT NULL,
	identification_number VARCHAR(11) NOT NULL,
    birth_date DATE NOT NULL,
	CONSTRAINT pk_candidates PRIMARY KEY (id),
	CONSTRAINT fk_candidates_users FOREIGN KEY (id) REFERENCES [dbo].users (id) ON DELETE CASCADE,
	CONSTRAINT uc_candidates_identification_number UNIQUE (identification_number)
);

CREATE TABLE employers (
	id INTEGER NOT NULL,
	company_name VARCHAR(255) NOT NULL,
	web_address VARCHAR(255) NOT NULL,
	CONSTRAINT pk_employers PRIMARY KEY (id),
	CONSTRAINT fk_employers_users FOREIGN KEY (id) REFERENCES [dbo].users (id) ON DELETE CASCADE,

);




CREATE TABLE employees(
	id INTEGER NOT NULL,
	first_name VARCHAR(35) NOT NULL,
	last_name VARCHAR(35) NOT NULL,
	CONSTRAINT pk_employees PRIMARY KEY (id),
	CONSTRAINT fk_employees_users FOREIGN KEY (id) REFERENCES [dbo].users (id) ON DELETE CASCADE
);

CREATE TABLE verification_codes(
	id INTEGER NOT NULL PRIMARY KEY  IDENTITY(1, 1),
	code VARCHAR(38) NOT NULL,
	is_verified bit NOT NULL,
	CONSTRAINT uc_verification_codes_code UNIQUE (code)
);

CREATE TABLE verification_codes_candidates(
	id INTEGER NOT NULL,
	candidate_id INTEGER NOT NULL,
	CONSTRAINT pk_verification_codes_candidates PRIMARY KEY (id),
	CONSTRAINT fk_verification_codes_candidates_verification_codes FOREIGN KEY (id) REFERENCES [dbo].verification_codes (id) ON DELETE CASCADE,
	CONSTRAINT fk_verification_codes_candidates_candidates FOREIGN KEY (candidate_id) REFERENCES [dbo].candidates (id) ON DELETE CASCADE
);

CREATE TABLE verification_codes_employers(
	id INTEGER NOT NULL,
	employer_id INTEGER NOT NULL,
	CONSTRAINT pk_verification_codes_employers PRIMARY KEY (id),
	CONSTRAINT fk_verification_codes_employers_verification_codes FOREIGN KEY (id) REFERENCES [dbo].verification_codes (id) ON DELETE CASCADE,
	CONSTRAINT fk_verification_codes_employers_employers FOREIGN KEY (employer_id) REFERENCES [dbo].employers (id) ON DELETE CASCADE
);

CREATE TABLE employee_confirms(
	id INTEGER NOT NULL PRIMARY KEY  IDENTITY(1, 1),
	employee_id INTEGER NOT NULL,
	is_confirmed bit  NOT NULL,
	CONSTRAINT fk_employee_confirms_employees FOREIGN KEY (employee_id) REFERENCES [dbo].employees (id) ON DELETE CASCADE
);

CREATE TABLE employee_confirms_employers(
	id INTEGER NOT NULL,
	employer_id INTEGER NOT NULL,
	CONSTRAINT pk_employee_confirms_employers PRIMARY KEY (id),
	CONSTRAINT fk_employee_confirms_employers_employee_confirms FOREIGN KEY (id) REFERENCES [dbo].employee_confirms (id) ,
	CONSTRAINT fk_employee_confirms_employers_employers FOREIGN KEY (employer_id) REFERENCES [dbo].employers (id) 
);

CREATE TABLE job_titles(
	id INTEGER NOT NULL PRIMARY KEY  IDENTITY(1, 1),
	title VARCHAR(255) NOT NULL,
	CONSTRAINT uc_job_titles_title UNIQUE (title)
);

