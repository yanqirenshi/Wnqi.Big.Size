CREATE TABLE wbs.rs_artifact (
     artifact_code INTEGER NOT NULL AUTO_INCREMENT
   , name VARCHAR(255)
   , description TEXT
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   /* index */
   , PRIMARY KEY (artifact_code)
);
