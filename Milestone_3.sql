CREATE TABLE `executive` (
  executive_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  position VARCHAR(50) NOT NULL, 
  description TEXT NOT NULL,
  hire_date DATE NOT NULL,
  compensation DOUBLE(10,2) NOT NULL
);

CREATE TABLE `member` (
  member_id		INTEGER	NOT NULL PRIMARY KEY AUTO_INCREMENT,
  first_name	VARCHAR(50)	NOT NULL, 
  last_name		VARCHAR(50)	NOT NULL, 
  email			VARCHAR(50)	NOT NULL, 
  phone			VARCHAR(11)	NOT NULL, 
  linkedin		VARCHAR(250) NULL,
  age			VARCHAR(3) NOT NULL,
  gender			CHAR(1)	NOT NULL, 
  race				VARCHAR(50) NOT NULL, 
  date_joined		DATE NOT NULL, 
  education			VARCHAR(200)NOT NULL, 
  program_level		INTEGER	NOT NULL, 
  wage				FLOAT NOT NULL, 
  date_of_birth		DATE NOT NULL, 
  ethnicity			VARCHAR(200) NOT NULL,
  juvenile_justice_system	CHAR NOT NULL, 
  previous_employement		CHAR(1) NOT NULL,
  single_parent_home		CHAR(1)	NOT NULL, 
  incarcerated_family		CHAR(1)	NOT NULL, 
  homeless					CHAR(1)	NOT NULL, 
  family_substance_abuse	CHAR(1) NOT NULL, 
  disability			CHAR(1) NOT NULL, 
  special_education		CHAR(1) NOT NULL, 
  dropout				CHAR(1) NOT NULL, 
  first_gen_college		CHAR(1) NOT NULL, 
  lgbtq					CHAR(1) NOT NULL, 
  pregnant_teen_parent	char(1) NOT NULL, 
  foster_care			CHAR(1) NOT NULL, 
  military_family 		CHAR(1) NOT NULL, 
  immigrant_refugee		CHAR(1) NOT NULL,
  free_reduced_lunch	CHAR(1) NOT NULL, 
  executive_id 			INTEGER NOT NULL,
  manager_id 			INTEGER,
  CONSTRAINT employee_fk1 FOREIGN KEY (manager_id) REFERENCES member(member_id)  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT employee_fk2 FOREIGN KEY (executive_id) REFERENCES executive(executive_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `check` (
  check_id		INTEGER		NOT NULL PRIMARY KEY AUTO_INCREMENT,
  member_id		INTEGER		NOT NULL,
  date			DATE		NOT NULL, 
  code			VARCHAR(50)	NOT NULL, 
  type			INTEGER	 NULL, 
  CONSTRAINT check_fk1 FOREIGN KEY (member_id) REFERENCES member(member_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `skill` (
  skill_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  skill_name VARCHAR(50) NOT NULL, 
  skill_task VARCHAR(50) NOT NULL;
);

CREATE TABLE `foundation` (
  foundation_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  foundation VARCHAR(75) NOT NULL,
  contact_first_name VARCHAR(50) NOT NULL,
  contact_last_name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  phone VARCHAR(12) NOT NULL 
);

CREATE TABLE `business_grant` (
  grant_id INTEGER NOT NULL AUTO_INCREMENT,
  date_issued DATE NOT NULL,
  grant_amount DOUBLE(10,2) NOT NULL,
  application_deadline DATETIME NOT NULL,
  executive_id INTEGER NOT NULL,
  foundation_id INTEGER NOT NULL,
  PRIMARY KEY (`grant_id`, `date_issued`),
  CONSTRAINT business_grant_fk1 FOREIGN KEY (executive_id) REFERENCES executive(executive_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT business_grant_fk2 FOREIGN KEY (foundation_id) REFERENCES foundation(foundation_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `instructor` (
  instructor_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL, 
  last_name VARCHAR(50) NOT NULL,
  organization VARCHAR(100) NOT NULL,
  email VARCHAR(50) NOT NULL,
  phone VARCHAR(12) NOT NULL,
  linkedin VARCHAR(50) NULL
);

CREATE TABLE `class` (
  class_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  type VARCHAR(50) NOT NULL, 
  goal_description TEXT NOT NULL,
  date DATE NOT NULL,
  instructor_id INTEGER NOT NULL,  
  CONSTRAINT claINTEGERIGN KEY (instructor_id) REFERENCES instructor(instructor_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `learning_objective` (
  objective_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  learning_objective TEXT NOT NULL, 
  objective_description TEXT NOT NULL
);

CREATE TABLE `member_skill` (
  member_id INTEGER NOT NULL,
  skill_id INTEGER NOT NULL,
  date_acquired DATE NOT NULL,
  PRIMARY KEY (`member_id`, `skill_id`),
  CONSTRAINT member_skill_fk1 FOREIGN KEY (member_id) REFERENCES member(member_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT member_skill_fk2 FOREIGN KEY (skill_id) REFERENCES skill(skill_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `member_class` (
  member_id INTEGER NOT NULL,
  class_id INTEGER NOT NULL,
  date_started DATE NOT NULL,
  date_completed DATE,
  PRIMARY KEY (`member_id`, `class_id`),
  CONSTRAINT member_class_fk1 FOREIGN KEY (member_id) REFERENCES member(member_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT member_class_fk2 FOREIGN KEY (class_id) REFERENCES class(class_id) ON ON DELETE CASCADE ON UPDATE CASCADE
); 

CREATE TABLE `executive_skill` (
  skill_id INTEGER NOT NULL,
  executive_id INTEGER NOT NULL,
  PRIMARY KEY (`skill_id`,executive_id`),
  CONSTRAINT executive_skill_fk1 FOREIGN KEY (skill_id) REFERENCES skill(skill_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT executive_skill_fk2 FOREIGN KEY (executive_id) REFERENCES executive(executive_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `class_objective` (
  objective_id INTEGER NOT NULL,
  class_id INTEGER NOT NULL,
  PRIMARY KEY (`objective_id`, `class_id`),
  CONSTRAINT class_objective_fk1 FOREIGN KEY (objective_id) REFERENCES learning_objective(objective_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT class_objective_fk2 FOREIGN KEY (class_id) REFERENCES class(class_id) ON DELETE CASCADE ON UPDATE CASCADE 
);

#2. d) A description of any (several more than three) queries you would need to perform against your database with a brief explanation of why this query is important. After identifying all queries, include the SQL for at least three of these queries. Two of these queries need to demonstrate the joining of two or more tables.

# Query 1: Member info for filing grant applications 
SELECT *
FROM `member`;

# Query 2: Performance evaluation - How many checks did Ch this month?
SELECT `first_name`, `last_name`, c.*
FROM `member` m 
INNER JOIN `check` c ON m.member_id = c.member_id
WHERE `first_name` = 'Cher'
  AND `last_name` = 'Campagne'  
  AND (MONTH(c.date) = MONTH(CURDATE()));
  
# Query 3: Which employees work in the bike shop?
SELECT first_name, last_name, skill_name
FROM member m 
INNER JOIN member_skill ms ON m.member_id = ms.member_id
INNER JOIN skill s ON s.skill_id = ms.skill_id
WHERE skill_name = 'Bike Repair';

# Query 4: Funding - Show all application  s subbmit applications for in the next 
SELECT *
FROM business_grant
WHERE (MONTH(CURDATE()) - MONTH(application_deadline)) <= 2;

# Query 5: Contact Instructor
SELECT *
FROM instructor i 
INNER JOIN class c ON i.instructor_id = c.instructor_id
WHERE type = 'nutrition';

#2. e) A description of any (a few more than one) views you would need to create with a brief explanation of why each view is important. After identifying all views, include the SQL for at least one of these views.

# View 1: Member View - important to provide members the capacity to insert and verify certain elements of their personal information. For example, being able to change their phone number or lgbtq status, while not being able to update things like their wage.
CREATE OR REPLACE VIEW `member_view` AS
SELECT `email`, `phone`, `linkedin`, `age`, `lgbtq` 
FROM `member`;

SELECT * 
FROM `member_view`;

# View 2: Bike Manager View - important for the bike manager to have access to information respective to members in the bike shop with skill, member, and check tables. Views provide extra security in only giving information access to those for whom it is relevant. The bike shop manager doesn't need to query anything in regards to things like business_grants, or classes, or instructors.


# View 3: CEO View - important for the CEO to have significant access to company information, while not receiving all abilities available to the DBA. Particularly with regards to funding and public relations. Creating a view for business_grant and foundation elements with aggregated columns for things like total funding received or average value of grants received.


#2. f) A description of at least three users that would need to access the database and the privileges they would need. Provide the SQL to grant these privileges to the users you listed (Note: you won't actually be able to run them).

# User 1: Member, Hermy Armstrong
CREATE USER `HermyArmstrong8`
IDENTIFIED BY 'password1';

GRANT select, insert, update 
ON `354groupb1`.`member`
TO `HermyArmstrong8`;

# User 2: Executive, Derby Capitano
CREATE USER `DerbyCapitano1`
IDENTIFIED BY 'password2';

GRANT all
ON `354groupb1`.*
TO `DerbyCapitano1`
WITH GRANT OPTION;

# User 3: Manager, Carter Crackel
CREATE USER `CarterCrackel5`
IDENTIFIED BY 'password3';

GRANT select
ON `354groupb1`.*
TO `CarterCrackel5`
WITH GRANT OPTION;