/** Author: Christine Vinaviles
    Student Number: 11986282
    Author: John Pham
    Student Number: 12061471
**/

/* GENERAL SELECT STATEMENTS */

/* Get all the columns and data that are in accounts */
SELECT * FROM accounts;
/*  Results:

   acc_id   |     acc_email     | acc_recovery_email | acc_recovery_phone |  acc_dob   | acc_gender |         acc_password         |  acc_type  | acc_manager_id
------------+-------------------+--------------------+--------------------+------------+------------+------------------------------+------------+----------------
 ac00001    | bob@bobbers.com   |                    | 04111111115        | 2000-06-11 | male       | dvlatoeupofjzdjkvc#R3efijaej | manager    |
 ac00002    | sad@sadders.com   | bop@sadders.com    | 04111111116        | 1980-12-16 | female     | ndsfoih4thslakdhg39rgd9gsid9 | manager    |
 ac00003    | happy@hoppers.com |                    | 04111111117        | 2010-02-11 | male       | 23424cref3ewr323r2fwee32dewf | child      | ac00001
*/

/* Get all the columns and data that are in channels */
SELECT * FROM channels;
/* Results: 

 channel_id | channel_name |              channel_description              | channel_created_at |   acc_id
------------+--------------+-----------------------------------------------+--------------------+------------
 ch00001    | chrisstime   | Sometimes I play music. Sometimes I am music. | 2014-09-12         | ac00001
*/

/* Get all the columns and data that are in playlists */
SELECT * FROM playlists;
/*   Results:

 playlist_id |  playlist_title  |       playlist_description       | channel_id
-------------+------------------+----------------------------------+------------
 pl00001     | Best covers ever | Playlist of the best covers ever | ch00001
*/


/* INNER JOIN STATEMENTS */

/* The query is joining all the channels that are owned by all accounts*/
SELECT * FROM accounts a INNER JOIN channels c ON c.acc_id = a.acc_id;
/* Results: 

   acc_id   |    acc_email    | acc_recovery_email | acc_recovery_phone |  acc_dob   | acc_gender |         acc_password         |  acc_type  | acc_manager_id | channel_id | channel_name |              channel_description              | channel_created_at |   acc_id
------------+-----------------+--------------------+--------------------+------------+------------+------------------------------+------------+----------------+------------+--------------+-----------------------------------------------+--------------------+------------
 ac00001    | bob@bobbers.com |                    | 04111111115        | 2000-06-11 | male       | dvlatoeupofjzdjkvc#R3efijaej | manager    |                | ch00001    | chrisstime   | Sometimes I play music. Sometimes I am music. | 2014-09-12         | ac00001/
*/

/* Combine the tables: accounts and invoices with the rows that share the same account id */
SELECT * FROM accounts a INNER JOIN invoices i on a.acc_id = i.acc_id;
/*   Results:

   acc_id   |    acc_email    | acc_recovery_email | acc_recovery_phone |  acc_dob   | acc_gender |         acc_password         |  acc_type  | acc_manager_id |   inv_no   | inv_issue_date | inv_start_date | inv_end_date |   mem_id   |   acc_id
------------+-----------------+--------------------+--------------------+------------+------------+------------------------------+------------+----------------+------------+----------------+----------------+--------------+------------+------------
 ac00002    | sad@sadders.com | bop@sadders.com    | 04111111116        | 1980-12-16 | female     | ndsfoih4thslakdhg39rgd9gsid9 | manager    |                | in00001    | 2015-04-15     | 2015-03-31     | 2015-04-14   | me00001    | ac00002
 ac00002    | sad@sadders.com | bop@sadders.com    | 04111111116        | 1980-12-16 | female     | ndsfoih4thslakdhg39rgd9gsid9 | manager    |                | in00002    | 2015-05-15     | 2015-04-15     | 2015-05-14   | me00002    | ac00002
 ac00002    | sad@sadders.com | bop@sadders.com    | 04111111116        | 1980-12-16 | female     | ndsfoih4thslakdhg39rgd9gsid9 | manager    |                | in00003    | 2015-06-15     | 2015-05-15     | 2015-06-14   | me00002    | ac00002
 ac00002    | sad@sadders.com | bop@sadders.com    | 04111111116        | 1980-12-16 | female     | ndsfoih4thslakdhg39rgd9gsid9 | manager    |                | in00004    | 2015-03-15     | 2015-06-15     | 2015-07-14   | me00002    | ac00002
 ac00001    | bob@bobbers.com |                    | 04111111115        | 2000-06-11 | male       | dvlatoeupofjzdjkvc#R3efijaej | manager    |                | in00005    | 2017-03-10     | 2017-03-09     | 2017-04-23   | me00003    | ac00001
 ac00001    | bob@bobbers.com |                    | 04111111115        | 2000-06-11 | male       | dvlatoeupofjzdjkvc#R3efijaej | manager    |                | in00006    | 2017-05-23     | 2017-04-23     | 2017-05-22   | me00004    | ac00001
 ac00001    | bob@bobbers.com |                    | 04111111115        | 2000-06-11 | male       | dvlatoeupofjzdjkvc#R3efijaej | manager    |                | in00007    | 2017-06-23     | 2017-05-23     | 2017-06-22   | me00004    | ac00001
 ac00001    | bob@bobbers.com |                    | 04111111115        | 2000-06-11 | male       | dvlatoeupofjzdjkvc#R3efijaej | manager    |                | in00008    | 2017-07-23     | 2017-06-23     | 2017-07-22   | me00004    | ac00001
*/


/* GROUP BY STATEMENTS */

/* Count the number of invoices that an account has and show with the account ID */
SELECT acc_id, COUNT(inv_no) FROM invoices GROUP BY acc_id;
/*   Results:

   acc_id   | count
------------+-------
 ac00001    |     4
 ac00002    |     4
*/

/* SUBQUERY STATEMENTS */

/* Find the account that is associated with the channel name chrisstime */
SELECT * FROM accounts a WHERE a.acc_id = (SELECT c.acc_id FROM channels c WHERE c.channel_name = 'chrisstime');
/* Results:

   acc_id   |    acc_email    | acc_recovery_email | acc_recovery_phone |  acc_dob   | acc_gender |         acc_password         |  acc_type  | acc_manager_id
------------+-----------------+--------------------+--------------------+------------+------------+------------------------------+------------+----------------
 ac00001    | bob@bobbers.com |                    | 04111111115        | 2000-06-11 | male       | dvlatoeupofjzdjkvc#R3efijaej | manager    |
=======
/*  Results:

 channel_id | channel_name |              channel_description              | channel_created_at |   acc_id
------------+--------------+-----------------------------------------------+--------------------+------------
 ch00001    | chrisstime   | Sometimes I play music. Sometimes I am music. | 2014-09-12         | ac00002
*/


/* Find the MOST RECENT membership type name, price and cycle of the account who owns/uploaded the "Baby Shark Accapella Cover" */
SELECT mtype_name, mtype_price, mtype_cycle_duration FROM membership_types WHERE mtype_id = (
    SELECT mtype_id FROM memberships WHERE acc_id = (
        SELECT acc_id FROM channels WHERE channel_id = (
            SELECT channel_id FROM videos WHERE vid_title = 'Baby Shark Accapella Cover'
            )
        )
    ORDER BY mem_start_at DESC LIMIT 1
);
/*   Results:

    mtype_name     | mtype_price | mtype_cycle_duration
-------------------+-------------+----------------------
 Single Membership |       14.99 | monthly
*/


