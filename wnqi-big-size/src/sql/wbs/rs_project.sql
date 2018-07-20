CREATE TABLE wbs.rs_project (
     _iid INTEGER NOT NULL AUTO_INCREMENT
   , project_code VARCHAR(55) NOT NULL UNIQUE
   , name VARCHAR(255)
   , description TEXT
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   /* index setting */
   , PRIMARY KEY (_iid)
);
