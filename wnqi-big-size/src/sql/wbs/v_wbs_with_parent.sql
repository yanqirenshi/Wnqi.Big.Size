CREATE VIEW wbs.v_wbs_with_parent AS
   SELECT rf_wbs.wbs_code_parent
        , rs_wbs.*
     FROM rs_wbs
LEFT JOIN rf_wbs
       ON rs_wbs.wbs_code = rf_wbs.wbs_code_child
;
