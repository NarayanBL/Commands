
SHOW DATABASES;                         # To see all Databases
CREATE DATABASE testdb;                 # Create a temp database
DROP DATABASE testdb;                   # Drop the temp database
CREATE DATABASE pets;
DROP DATABASE pets;
USE pets;
CREATE TABLE cats
(
  id              INT unsigned NOT NULL AUTO_INCREMENT, # Unique ID for the record
  name            VARCHAR(150) NOT NULL,                # Name of the cat
  owner           VARCHAR(150) NOT NULL,                # Owner of the cat
  birth           DATE NOT NULL,                        # Birthday of the cat
  PRIMARY KEY     (id)                                  # Make the id the primary key
);
SHOW TABLES;
DESCRIBE cats;
INSERT INTO cats ( name, owner, birth) VALUES
  ( 'Sandy', 'Lennon', '2015-01-03' ),
  ( 'Cookie', 'Casey', '2013-11-13' ),
  ( 'Charlie', 'River', '2016-05-21' );
SELECT * FROM cats;
SELECT name FROM cats WHERE owner = 'Casey';
DELETE FROM cats WHERE name='Cookie';
ALTER TABLE cats ADD gender CHAR(1) AFTER name;
ALTER TABLE cats DROP gender;
DROP DATABASE pets;
SHOW TABLES;


SHOW DATABASES;
use payroll_service;
select database();
Show tables;
DESCRIBE employee_payroll;
SELECT * FROM employee_payroll;
SELECT * FROM employee_payroll 
WHERE start BETWEEN CAST('2018-01-01' AS DATE) AND DATE(NOW());
SELECT gender, AVG(salary) FROM employee_payroll GROUP BY gender;

/usr/local/mysql/bin/mysql -u root -p   # Run mysql client
SHOW DATABASES;                         # To see all Databases
# UC 1
CREATE DATABASE payroll_service;        # Create database
USE payroll_service;                    # To use payroll_service Database 
SELECT DATABASE();                      # To see current data base :  

# UC 2
CREATE TABLE employee_payroll           # Crate Table
(
  id           INT UNSIGNED NOT NULL AUTO_INCREMENT, # Unique ID for the record
  name         VARCHAR(150) NOT NULL,                # Name of the Employee
  salary       Double NOT NULL,                      # Employee Salary
  start        DATE NOT NULL,                        # Employee Start Date
  PRIMARY KEY  (id)                                  # Make id primary key
);
DROP TABLE employee_payroll;     # Drop Table employee_payroll
DESCRIBE employee_payroll;       # Describe Table

# UC 3
INSERT INTO employee_payroll ( name, salary, start) VALUES 
    ( 'Bill', 1000000.00, '2018-01-03' ),
    ( 'Terisa', 2000000.00, '2019-11-13' ),
    ( 'Charlie', 3000000.00, '2020-05-21' );

# UC 4
SELECT * FROM employee_payroll;                              # Retrieving Records from Table

# UC 5
SELECT salary FROM employee_payroll WHERE name = 'Bill';     # Selecting Bill Entry
SELECT * FROM employee_payroll 
WHERE start BETWEEN CAST('2018-01-01' AS DATE) AND DATE(NOW());

# UC 6
ALTER TABLE employee_payroll ADD gender CHAR(1) AFTER name;  # Adding gender field 
update employee_payroll set gender = 'F' where name = 'Terisa';
update employee_payroll set gender = 'M' where name = 'Bill' or name = 'Charlie';
update employee_payroll set salary = 3000000.00 where name = 'Terisa';

# UC 7
SELECT gender, AVG(salary) FROM employee_payroll WHERE gender = 'M' GROUP BY gender;
SELECT gender, AVG(salary) as avg_salary FROM employee_payroll GROUP BY gender;

# Demo Delete do re insert. Essentially will get a new Emp ID
DELETE FROM employee_payroll WHERE name='Bill';              # Deleting Bill Entry

# UC 8
ALTER TABLE employee_payroll ADD phone_mumber VARCHAR(250) AFTER name;  # Adding phone_mumber field 
ALTER TABLE employee_payroll ADD address VARCHAR(250) AFTER phone_mumber;  # Adding address field 
ALTER TABLE employee_payroll ADD department VARCHAR(150) NOT NULL AFTER address; # Adding department field 
ALTER TABLE employee_payroll ALTER address SET DEFAULT 'TBD'; # Setting Default Value
INSERT INTO employee_payroll ( name, salary, start) VALUES (  'Bill', 1000000.00, '2018-01-03' )

# UC 9
ALTER TABLE employee_payroll RENAME COLUMN salary TO basic_pay;
ALTER TABLE employee_payroll ADD deductions Double NOT NULL AFTER basic_pay;  
ALTER TABLE employee_payroll ADD taxable_pay Double NOT NULL AFTER deductions;  
ALTER TABLE employee_payroll ADD tax Double NOT NULL AFTER taxable_pay;  
ALTER TABLE employee_payroll ADD net_pay Double NOT NULL AFTER tax;  

update employee_payroll set department = 'Sales' where name = 'Terisa';
INSERT INTO employee_payroll 
(name, department, gender, basic_pay, deductions, taxable_pay, tax, net_pay, start) VALUES 
('Terisa', 'Marketting', 'F', 3000000.00, 1000000.00, 2000000.00, 500000.00, 1500000.00, '2018-01-03' );

CREATE TABLE payroll_details
(
  employee_id   INT UNSIGNED NOT NULL,
  basic_pay     Double NOT NULL,
  deductions    Double NOT NULL,
  taxable_pay   Double NOT NULL,
  tax           Double NOT NULL,
  net_pay       Double NOT NULL,
  FOREIGN KEY (employee_id)
      REFERENCES employee_payroll (id)
      ON DELETE CASCADE
);
DROP TABLE payroll_details;

INSERT INTO employee_payroll ( name, gender, salary, start) VALUES (  'Mark', 'M', 5000000.00, DATE(NOW()) );
INSERT INTO payroll_details 
(employee_id, basic_pay, deductions, taxable_pay, tax, net_pay) VALUES 
( 15, 3000000.00, 1000000.00, 2000000.00, 500000.00, 1500000.00 );
select * from employee_payroll, payroll_details where id = employee_id;
DELETE FROM employee_payroll WHERE name='Mark';
DELETE FROM employee_payroll WHERE id > 15;
DELETE FROM payroll_details where employee_id = 6;

ALTER TABLE employee_payroll DROP gender;                    # Dropping gender field
DROP DATABASE payroll_service;                               # Dropping payroll_service DATABASE
Cntr L # To Clear Screen
update employee_payroll set gender = 'F' where name = 'Terisa';

# Connection Queries
show session status;
SHOW STATUS WHERE `variable_name` = 'Max_used_connections';
SHOW STATUS WHERE `variable_name` = 'Threads_connected';