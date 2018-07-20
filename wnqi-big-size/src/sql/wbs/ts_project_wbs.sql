CREATE TABLE wbs.ts_project_wbs (
     _iid INTEGER NOT NULL AUTO_INCREMENT
   , project_code VARCHAR(55) NOT NULL
   , wbs_code INTEGER NOT NULL
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   /* index */
   , PRIMARY KEY (_iid)
   , UNIQUE(project_code, wbs_code)
);
