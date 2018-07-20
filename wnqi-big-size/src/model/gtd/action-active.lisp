(in-package :wbs)

(defclass action-active ()
  ((action-code :accessor action-code
                :initarg :action-code
                :initform nil
                :col-type :serial
                :primary-key t)
   (description :col-type :texto
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
               :accessor updated-by)
   (updated-at :col-type :timestamp
               :initarg :updated-at
               :initform nil
               :accessor updated-at))
  (:table-name "gtd.rs_action_active")
  (:record-timestamps nil)
  (:metaclass mito:dao-table-class))


(defun get-action-active-at-code-&-parson-sql ()
  (select (:t4.*)
    (from (:as :gtd.ts_parson_bucket :t1))
    (inner-join (:as :gtd.rs_bucket_active :t2)
                :on (:= :t1.bucket_code :t2.bucket_code))
    (inner-join (:as :gtd.ts_bucket_action :t3)
                :on (:= :t2.bucket_code :t3.bucket_code))
    (inner-join (:as :gtd.rs_action_active :t4)
                :on (:= :t3.action_code :t4.action_code))
    (where (:and (:= :t4.action_code :?)
                 (:= :t1.parson_code :?)))))

(defun plist2action-active (plist)
  (when plist
    (record-2-dao-new plist 'action-active
                      :action-code (getf plist :|action_code|)
                      :description (getf plist :|description|))))

(defun get-action-active-at-code-&-parson (action-code parson)
  (plist2action-active
   (car (retrieve (get-action-active-at-code-&-parson-sql)
                  action-code
                  (parson-code parson)))))

(defun get-action-active (&key code parson)
  (cond ((and code (null parson))
         (mito:find-dao 'action-active
                        :action-code code))
        ((and code parson)
         (get-action-active-at-code-&-parson code parson))
        (t nil)))

(defun create-action-active (description &key user-code parson)
  (let ((creator-code (or user-code (by parson))))
    (mito:create-dao 'action-active
                     :description description
                     :created-at (local-time:now)
                     :created-by creator-code
                     :updated-at (local-time:now)
                     :updated-by creator-code)))
