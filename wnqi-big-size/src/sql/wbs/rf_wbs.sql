CREATE TABLE wbs.rf_wbs (
     _iid INTEGER NOT NULL AUTO_INCREMENT
   , wbs_code_parent INTEGER NOT NULL
   , wbs_code_child INTEGER NOT NULL
   /* timestamp */
   , created_at DATETIME
   , created_by VARCHAR(255)
   , updated_at DATETIME
   , updated_by VARCHAR(255)
   /* index */
   , PRIMARY KEY (_iid)
   , UNIQUE(wbs_code_parent, wbs_code_child)
);
