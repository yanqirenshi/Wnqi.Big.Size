CREATE TABLE acc.rs_user (
     _iid INTEGER NOT NULL AUTO_INCREMENT
   , user_code VARCHAR(50)
   , name VARCHAR(255)
   , description TEXT
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   /* index */
   , PRIMARY KEY (_iid)
   , UNIQUE(user_code)
);
