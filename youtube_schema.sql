/** Author: Christine Vinaviles
    Student Number: 11986282
    Author: John Pham
    Student Number: 
**/

DROP TABLE accounts;
DROP TABLE channels;
DROP TABLE memberships;
DROP TABLE membership_types;
DROP TABLE invoices;
DROP TABLE videos;
DROP TABLE playlists;
DROP TABLE plalist_items;


CREATE TABLE Accounts(
    acc_id                  char(10)            NOT NULL,
    acc_email               varchar(30)         NOT NULL,
    acc_recovery_email      varchar(30),
    acc_recovery_phone      varchar(20),
    acc_dob                 date                NOT NULL,
    acc_gender              char(10)            NOT NULL,
    acc_password            varchar(30)         NOT NULL,
    acc_type                char(10)            NOT NULL,
    acc_manager_id          char(10), 
    PRIMARY KEY (acc_id)
);

INSERT INTO Accounts (acc_id, acc_email, acc_recovery_phone, acc_dob, acc_gender, acc_password,
    acc_type) VALUES ('ac00001', 'bob@bobbers.com', '04111111116', '11-Jun-1980', 
    '23424cref3ewr323r2fwee32dewfwer3rfewa', 'male', 'manager');
