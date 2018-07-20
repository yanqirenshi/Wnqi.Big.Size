CREATE TABLE gtd.ts_parson_bucket (
     _iid INTEGER NOT NULL AUTO_INCREMENT
   , parson_code  INTEGER NOT NULL
   , bucket_code INTEGER NOT NULL
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   , PRIMARY KEY (_iid)
);
