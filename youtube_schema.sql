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
    CONSTRAINT accounts_pk PRIMARY KEY (acc_id)
);
CREATE TABLE channels (
    channel_id            char(10)             NOT NULL,
    channel_name          varchar(25)          NOT NULL,
    channel_description   varchar(75),
    channel_created_at    date                 NOT NULL,
    acc_id                char(10)             NOT NULL,
    CONSTRAINT channels_pk PRIMARY KEY (channel_id),
    CONSTRAINT channels_fk1 FOREIGN KEY (acc_id) REFERENCES accounts (acc_id)
);
CREATE TABLE playlists (
    playlist_id             char(10)           NOT NULL,
    playlist_title          varchar(30)        NOT NULL,
    playlist_description    varchar(255),
    channel_id              char(10)           NOT NULL,   
    CONSTRAINT playlist_pk PRIMARY KEY (playlist_id),
    CONSTRAINT playlist_fk1 FOREIGN KEY (channel_id) REFERENCES channels (channel_id)
);
CREATE TABLE videos (
    vid_id                    char(10)          NOT NULL,
    vid_title                 varchar(30)       NOT NULL,
    vid_description           varchar(255),
    vid_message               varchar(255),
    vid_privacy_setting       varchar(255)      NOT NULL,
    channel_id                char(10)          NOT NULL,
    CONSTRAINT videos_pk PRIMARY KEY (vid_id),
    CONSTRAINT videos_fk1 FOREIGN KEY (channel_id) REFERENCES channels (channel_id)
);
CREATE TABLE playlist_items (
    playlist_item_position    int                 NOT NULL,
    playlist_id               varchar(10)         NOT NULL,
    vid_id                    varchar(10)         NOT NULL,
    CONSTRAINT playlist_items_pk PRIMARY KEY (playlist_id, vid_id)
);
/* We are assuming here that we only provide the cycle duration i.e. monthly, weekly etc. in string format
   and the actual membership timing renewal logic is done on the application end of the service.
 */
CREATE TABLE membership_types (
    mtype_id              char(10)         NOT NULL,
    mtype_name            varchar(25)      NOT NULL,
    mtype_price           decimal(5,2)     NOT NULL,
    mtype_cycle_duration   varchar(15)      NOT NULL,
    mtype_description     varchar(50),
    CONSTRAINT membership_types_pk PRIMARY KEY (mtype_id)
);
CREATE TABLE memberships (
    mem_id              char(10)        NOT NULL,
    mem_start_at        date            NOT NULL,
    mtype_id            char(10)        NOT NULL,
    acc_id              char(10)        NOT NULL,
    CONSTRAINT memberships_pk PRIMARY KEY (mem_id),
    CONSTRAINT memberships_fk1 FOREIGN KEY (mtype_id) REFERENCES membership_types (mtype_id),
    CONSTRAINT memberships_fk2 FOREIGN KEY (acc_id) REFERENCES accounts (acc_id)
);
/* This includes payment types which has been ommitted from this schema */
CREATE TABLE invoices (
    inv_no               char(10)         NOT NULL,
    inv_issue_date       date             NOT NULL,
    inv_start_date       date             NOT NULL,
    inv_end_date         date             NOT NULL,
    mem_id               char(10)         NOT NULL,
    acc_id               char(10)         NOT NULL,
    CONSTRAINT invoices_pk PRIMARY KEY (inv_no),
    CONSTRAINT invoices_fk1 FOREIGN KEY (mem_id) REFERENCES memberships (mem_id),
    CONSTRAINT invoices_fk2 FOREIGN KEY (acc_id) REFERENCES accounts (acc_id)
);

/* Insert dummy data */
INSERT INTO accounts (acc_id, acc_email, acc_recovery_phone, acc_dob, acc_gender, acc_password, acc_type)
    VALUES ('ac00001', 'bob@bobbers.com', '04111111115', '11-Jun-2000', 'male', 'dvlatoeupofjzdjkvc#R3efijaej', 'manager');
INSERT INTO accounts (acc_id, acc_email, acc_recovery_phone, acc_recovery_email, acc_dob, acc_gender, acc_password, acc_type)
    VALUES ('ac00002', 'sad@sadders.com', '04111111116', 'bop@sadders.com', '16-Dec-1980', 'female', 'ndsfoih4thslakdhg39rgd9gsid9', 'manager');
INSERT INTO accounts (acc_id, acc_email, acc_recovery_phone, acc_dob, acc_gender, acc_password, acc_type, acc_manager_id) 
    VALUES ('ac00003', 'happy@hoppers.com', '04111111117', '11-Feb-2010', 'male', '23424cref3ewr323r2fwee32dewf', 'child', 'ac00001');

INSERT INTO channels (channel_id, channel_name, channel_description, channel_created_at, acc_id)
    VALUES ('ch00001', 'chrisstime', 'Sometimes I play music. Sometimes I am music.', '12-Sep-2014', 'ac00001');

INSERT INTO videos (vid_id, vid_title, vid_description, vid_message, vid_privacy_setting, channel_id)
    VALUES ('v00001', 'Baby Shark Accapella Cover', 'I really put a lot of effort please like', 'Please watch', 'Public', 'ch00001');

INSERT INTO playlists (playlist_id, playlist_title, playlist_description, channel_id)
    VALUES ('pl00001', 'Best covers ever', 'Playlist of the best covers ever', 'ch00001');
INSERT INTO playlist_items (playlist_item_position, playlist_id, vid_id)
    VALUES (1, 'pl00001', 'v00001');

INSERT INTO membership_types VALUES ('mt00001', 'Single Membership', 14.99, 'monthly', '');
INSERT INTO membership_types VALUES ('mt00002', 'Family Membership', 17.99, 'monthly', 'Enjoy with no ads with your entire family!');
INSERT INTO membership_types VALUES ('mt00003', 'Trial Membership', 0.00, 'fornight', 'Free premium trial for 2 weeks.');

INSERT INTO memberships VALUES ('me00001', '31-Mar-2015', 'mt00003', 'ac00002');
INSERT INTO memberships VALUES ('me00002', '15-Apr-2015', 'mt00001', 'ac00002');
INSERT INTO memberships VALUES ('me00003', '9-Mar-2017', 'mt00003', 'ac00001');
INSERT INTO memberships VALUES ('me00004', '23-Mar-2017', 'mt00002', 'ac00001');

INSERT INTO invoices VALUES ('in00001', '15-Apr-2015', '31-Mar-2015', '14-Apr-2015', 'me00001', 'ac00002');
INSERT INTO invoices VALUES ('in00002', '15-May-2015', '15-Apr-2015', '14-May-2015', 'me00002', 'ac00002');
INSERT INTO invoices VALUES ('in00003', '15-Jun-2015', '15-May-2015', '14-Jun-2015', 'me00002', 'ac00002');
INSERT INTO invoices VALUES ('in00004', '15-Mar-2015', '15-Jun-2015', '14-Jul-2015', 'me00002', 'ac00002');
INSERT INTO invoices VALUES ('in00005', '10-Mar-2017', '9-Mar-2017', '23-Apr-2017', 'me00003', 'ac00001');
INSERT INTO invoices VALUES ('in00006', '23-May-2017', '23-Apr-2017', '22-May-2017', 'me00004', 'ac00001');
INSERT INTO invoices VALUES ('in00007', '23-Jun-2017', '23-May-2017', '22-Jun-2017', 'me00004', 'ac00001');
INSERT INTO invoices VALUES ('in00008', '23-Jul-2017', '23-Jun-2017', '22-Jul-2017', 'me00004', 'ac00001');

