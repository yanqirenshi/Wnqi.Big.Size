CREATE TABLE gtd.rs_action_active (
     action_code INTEGER NOT NULL AUTO_INCREMENT
   , description TEXT
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   , PRIMARY KEY (action_code)
);
