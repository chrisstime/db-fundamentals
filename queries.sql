/** 
    Part D Database Fundamentals
    Author: Christine Vinaviles
    Student Number: 11986282
    Author: John Pham
    Student Number: 12061471
**/

SELECT * FROM accounts;
SELECT * FROM channels;

/* The query is joining all the channels that are owned by all accounts*/
SELECT * FROM accounts a INNER JOIN channels c ON c.acc_id = a.acc_id;
/*
   acc_id   |    acc_email    | acc_recovery_email | acc_recovery_phone |  acc_dob   | acc_gender |         acc_password         |  acc_type  | acc_manager_id | channel_id | channel_name |              channel_description              | channel_created_at |   acc_id
------------+-----------------+--------------------+--------------------+------------+------------+------------------------------+------------+----------------+------------+--------------+-----------------------------------------------+--------------------+------------
 ac00001    | bob@bobbers.com |                    | 04111111115        | 2000-06-11 | male       | dvlatoeupofjzdjkvc#R3efijaej | manager    |                | ch00001    | chrisstime   | Sometimes I play music. Sometimes I am music. | 2014-09-12         | ac00001/
*/

/* Query is finding the account that is associated with the channel name chrisstime */
SELECT * FROM accounts a WHERE a.acc_id = (SELECT c.acc_id FROM channels c WHERE c.channel_name = 'chrisstime');
/*
   acc_id   |    acc_email    | acc_recovery_email | acc_recovery_phone |  acc_dob   | acc_gender |         acc_password         |  acc_type  | acc_manager_id
------------+-----------------+--------------------+--------------------+------------+------------+------------------------------+------------+----------------
 ac00001    | bob@bobbers.com |                    | 04111111115        | 2000-06-11 | male       | dvlatoeupofjzdjkvc#R3efijaej | manager    |
*/
