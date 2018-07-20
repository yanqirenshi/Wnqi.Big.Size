CREATE TABLE org.ts_user_parson (
     _iid INTEGER NOT NULL AUTO_INCREMENT
   , user_code VARCHAR(55) NOT NULL
   , parson_code INTEGER NOT NULL
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   /* index */
   , PRIMARY KEY (_iid)
   , UNIQUE(user_code, parson_code)
);
