/** Author: Christine Vinaviles
    Student Number: 11986282
    Author: John Pham
    Student Number: 
**/

DROP TABLE accounts         CASCADE;
DROP TABLE channels         CASCADE;
DROP TABLE memberships      CASCADE;
DROP TABLE membership_types CASCADE;
DROP TABLE invoices         CASCADE;
DROP TABLE videos           CASCADE;
DROP TABLE playlists        CASCADE;
DROP TABLE playlist_items   CASCADE;


CREATE TABLE accounts(
    acc_id                  char(10)            NOT NULL,
    acc_email               varchar(30)         NOT NULL,
    acc_recovery_email      varchar(30),
    acc_recovery_phone      varchar(30),
    acc_dob                 date                NOT NULL,
    acc_gender              char(10)            NOT NULL,
    acc_password            varchar(30)         NOT NULL,
    acc_type                char(10)            NOT NULL,
    acc_manager_id          char(10), 
    PRIMARY KEY (acc_id)
);
INSERT INTO accounts (acc_id, acc_email, acc_recovery_phone, acc_dob, acc_gender, acc_password,
    acc_type) VALUES ('ac00001', 'bob@bobbers.com', '04111111115', '11-Jun-2000', 'male',
    'dvlatoeupofjzdjkvc#R3efijaej', 'manager');
INSERT INTO accounts (acc_id, acc_email, acc_recovery_phone, acc_recovery_email, acc_dob,
     acc_gender, acc_password, acc_type) VALUES ('ac00002', 'sad@sadders.com', '04111111116',
     'bop@sadders.com', '16-Dec-1980', 'female', 'ndsfoih4thslakdhg39rgd9gsid9', 'manager');
INSERT INTO accounts (acc_id, acc_email, acc_recovery_phone, acc_dob, acc_gender, acc_password,
    acc_type, acc_manager_id) VALUES ('ac00003', 'happy@hoppers.com', '04111111117', '11-Feb-2010',
    'male', '23424cref3ewr323r2fwee32dewf', 'child', 'ac00001');

CREATE TABLE channels (
    channel_id            char(10)            NOT NULL,
    channel_name          varchar(25)         NOT NULL,
    channel_description   varchar(75),
    channel_created_at    date                NOT NULL,
    acc_id                char(10)            NOT NULL,
    CONSTRAINT channels_fk PRIMARY KEY (channel_id),
    CONSTRAINT channels_fk FOREIGN KEY (acc_id) REFERENCES accounts(acc_id)
)
INSERT INTO channels (channel_id, channel_name, channel_description, channel_created_at, acc_id)
    VALUES ('ch00002', 'chrisstime', 'Sometimes I play music. Sometimes I am music.', '12-Sep-2015'
    'ac00001');
    
CREATE TABLE playlists (
    playlist_id             varchar(10)         NOT NULL,
    playlist_title          varchar(30),
    playlist_description    varchar(255),
    CONSTRAINT playlist_pk PRIMARY KEY (playlist_id),
    CONSTRAINT playlist_fk1 FOREIGN KEY (channel_id) REFERENCES channels (channel_id)
);
CREATE TABLE videos (
  vid_id                    varchar(10),
  vid_title                 varchar(20),
  vid_description           varchar(255),
  vid_message               varchar(255),
  vid_privacy_setting       varchar(255),
  CONSTRAINT videos_pk PRIMARY KEY (vid_id),
  CONSTRAINT videos_fk1 FOREIGN KEY (channel_id) REFERENCES channels (channel_id)
);
CREATE TABLE playlist_items (
  playlist_item_position    int                 NOT NULL,
  playlist_id               varchar(10)         NOT NULL,
  vid_id                    varchar(10)         NOT NULL,
  CONSTRAINT playlist_items_pk PRIMARY KEY (playlist_id, vid_id)
);
