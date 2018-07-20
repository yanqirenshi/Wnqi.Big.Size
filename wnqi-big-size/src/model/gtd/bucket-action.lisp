(in-package :wbs)

(defclass bucket-action ()
  ((iid :accessor iid
        :initarg :iid
        :initform nil
        :col-type :serial
        :primary-key t)
   (bucket-code :accessor bucket-code
                :initarg :bucket-code
                :initform nil
                :col-type :integer)
   (action-code :accessor action-code
                :initarg :action-code
                :initform nil
                :col-type :integer)
   (created-by :col-type (:varchar 255)
               :initarg :created-by
               :accessor created-by)
   (updated-by :col-type (:varchar 255)
               :initarg :updated-by
               :accessor updated-by))
  (:table-name "gtd.ts_bucket_action")
  (:metaclass mito:dao-table-class))

(defun get-bucket-action (&key bucket action)
  (car (mito:select-dao 'bucket-action
         (where (:and (:= :bucket-code (bucket-code bucket))
                      (:= :action-code (action-code action)))))))

(defun delete-bucket-action (bucket action)
  (let ((dao (get-bucket-action :bucket bucket
                                :action action)))
    (when dao
      (mito:delete-dao dao))))

(defgeneric make-bucket-action (bucket action &key creator)
  (:method ((bucket bucket-active) (action action-active) &key creator)
    (let ((creator-code (by creator)))
      (mito:create-dao 'bucket-action
                       :bucket-code (bucket-code bucket)
                       :action-code (action-code action)
                       :created-by creator-code
                       :updated-by creator-code))))
