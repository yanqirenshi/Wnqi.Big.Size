CREATE TABLE gtd.ts_bucket_action (
     _iid INTEGER NOT NULL AUTO_INCREMENT
   , action_code  INTEGER NOT NULL
   , bucket_code INTEGER NOT NULL
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   , PRIMARY KEY (_iid)
);
