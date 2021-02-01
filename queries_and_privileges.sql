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
SELECT email, `phone`, `linkedin`, `age`, `lgbtq` 
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