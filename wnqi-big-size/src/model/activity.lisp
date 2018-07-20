(in-package :wbs)

(defclass activity ()
  ((activity-code :primary-key t
                  :col-type :serial
                  :initarg :activity-code
                  :initform nil
                  :accessor activity-code)
   (title :col-type (:varchar 255)
          :initarg :title
          :accessor title)
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
  (:table-name "wbs.rs_activity")
  (:metaclass mito:dao-table-class))

(defun get-activity (&key code)
  (when code
    (mito:find-dao 'activity :activity-code code)))

(defun create-activity (title &optional (description "") (user-code "renshi"))
  (mito:create-dao 'activity
                   :title title
                   :description description
                   :created-by user-code
                   :updated-by user-code))

(defun find-activity ()
  (mito:select-dao 'activity))
