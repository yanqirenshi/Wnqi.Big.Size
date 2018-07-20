CREATE TABLE gtd.rs_bucket_archive (
     bucket_code INTEGER NOT NULL
   , name VARCHAR(255)
   , description TEXT
   , bucket_type INTEGER NOT NULL
   , order_number INTEGER NOT NULL
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   , PRIMARY KEY (bucket_code)
);
