CREATE TABLE gtd.ev_action_stop (
     iid INTEGER NOT NULL
   , action_code INTEGER NOT NULL
   , parson_code VARCHAR(50) NOT NULL
   , description TEXT NOT NULL
   , start_time DATETIME NOT NULL
   , end_time DATETIME NOT NULL
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   , PRIMARY KEY (iid)
);
