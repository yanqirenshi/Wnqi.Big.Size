CREATE TABLE gtd.rs_action_archive (
     action_code INTEGER NOT NULL
   , description TEXT
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   , PRIMARY KEY (action_code)
);
