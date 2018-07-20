(in-package :wbs)

(defclass action ()
  ((action-code :col-type :integer
                :initarg :action-code
                :accessor action-code)
   (bucket-code :col-type :integer
                :initarg :bucket-code
                :initform nil
                :accessor bucket-code)
   (status :col-type :symbol
           :initarg :status
           :initform nil)
   (description :col-type :text
                :initarg :description
                :accessor description
                :initform "")
   (created-by :col-type (:varchar 255)
               :initarg :created-by
               :accessor created-by)
   (updated-by :col-type (:varchar 255)
               :initarg :updated-by
               :accessor updated-by))
  (:table-name "gtd.rs_action")
  (:metaclass mito:dao-table-class))

;;;
;;; find-action
;;;
(defun find-action-sql (table)
  (select (:t1.bucket_code
           (:as :? :status)
           :t4.*)
    (from (:as :gtd.ts_parson_bucket :t1))
    (inner-join (:as :gtd.rs_bucket_active :t2)
                :on (:= :t1.bucket_code :t2.bucket_code))
    (inner-join (:as :gtd.ts_bucket_action :t3)
                :on (:= :t2.bucket_code :t3.bucket_code))
    (inner-join (:as table :t4)
                :on (:= :t3.action_code :t4.action_code))
    (where (:= :t1.parson_code :?))))

(defun rec2action (rec)
  (when rec
    (record-2-dao rec 'action
                  :action-code (getf rec :|action_code|)
                  :bucket-code (getf rec :|bucket_code|)
                  :status (getf rec :|status|)
                  :description (getf rec :|description|)
                  :created-by (getf rec :|created_by|)
                  :updated-by (getf rec :|updated_by|))))

(defun %find-action (status table parson)
  (mapcar #'rec2action
          (retrieve (find-action-sql table)
                    status
                    (parson-code parson))))

(defun find-action (&key parson (target :active))
  (assert parson)
  (cond ((eq target :active)
         (%find-action "ACTIVE" :gtd.rs_action_active parson))
        ((eq target :archive)
         (%find-action "ARCHIVE" :gtd.rs_action_archive parson))
        ((eq target :all)
         (nconc (find-action :parson parson :target :active)
                (find-action :parson parson :target :archive)))
        (t (error "invalid target. taget=~a" target))))

(defun get-action-sql ()
  (select (:t1.bucket_code
           :t4.*)
    (from (:as :gtd.ts_parson_bucket :t1))
    (inner-join (:as :gtd.rs_bucket_active :t2)
                :on (:= :t1.bucket_code :t2.bucket_code))
    (inner-join (:as :gtd.ts_bucket_action :t3)
                :on (:= :t2.bucket_code :t3.bucket_code))
    (inner-join (:as :gtd.rs_action_active :t4)
                :on (:= :t3.action_code :t4.action_code))
    (where (:and (:= :t1.parson_code :?)
                 (:= :t4.action_code :?)))))

(defun get-action (&key action action-code parson)
  (rec2action (car (retrieve (get-action-sql)
                             (parson-code parson)
                             (or action-code
                                 (action-code action))))))
