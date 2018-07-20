CREATE TABLE wbs.rs_activity (
     activity_code INTEGER NOT NULL AUTO_INCREMENT
   , title VARCHAR(255)
   , description TEXT
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   , PRIMARY KEY (activity_code)
);
