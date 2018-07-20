(in-package :wbs)

(defclass action-archive ()
  ((action-code :accessor action-code
                :initarg :action-code
                :initform nil
                :col-type :integer)
   (description :col-type :text
                :initarg :description
                :accessor description
                :initform "")
   (created-by :col-type (:varchar 255)
               :initarg :created-by
               :accessor created-by)
   (created-at :col-type :timestamp
               :initarg :created-at
               :accessor created-at)
   (updated-by :col-type (:varchar 255)
               :initarg :updated-by
               :initform nil
               :accessor updated-by)
   (updated-at :col-type :timestamp
               :initarg :updated-at
               :initform nil
               :accessor updated-at))
  (:table-name "gtd.rs_action_archive")
  (:record-timestamps nil)
  (:metaclass mito:dao-table-class))

(defun get-action-archive-at-code-&-parson-sql ()
  (select (:t4.*)
    (from (:as :gtd.ts_parson_bucket :t1))
    (inner-join (:as :gtd.rs_bucket_active :t2)
                :on (:= :t1.bucket_code :t2.bucket_code))
    (inner-join (:as :gtd.ts_bucket_action :t3)
                :on (:= :t2.bucket_code :t3.bucket_code))
    (inner-join (:as :gtd.rs_action_archive :t4)
                :on (:= :t3.action_code :t4.action_code))
    (where (:and (:= :t4.action_code :?)
                 (:= :t1.parson_code :?)))))

(defun plist2action-archive (plist)
  (when plist
      (record-2-dao-new plist 'action-archive
                        :action-code (getf plist :|action_code|)
                        :description (getf plist :|description|))))

(defun get-action-archive-at-code-&-parson (action-code parson)
  (plist2action-archive
   (car (retrieve (get-action-archive-at-code-&-parson-sql)
                  action-code
                  (parson-code parson)))))

(defun get-action-archive (&key code parson)
  (cond ((and code (null parson))
         (mito:find-dao 'action-archive
                        :action-code code))
        ((and code parson)
         (get-action-archive-at-code-&-parson code parson))
        (t nil)))
