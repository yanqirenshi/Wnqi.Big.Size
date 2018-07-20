(in-package :wbs)

(defclass wbs ()
  ((wbs-code :col-type :serial
             :initarg :wbs-code
             :initform nil
             :accessor wbs-code
             :primary-key t)
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
  (:table-name "wbs.rs_wbs")
  (:metaclass mito:dao-table-class))

(defun get-wbs (&key code)
  (when code
    (mito:find-dao 'wbs :wbs-code code)))

(defun create-wbs (title &optional (description "") (user-code "renshi"))
  (mito:create-dao 'wbs
                   :title title
                   :description description
                   :created-by user-code
                   :updated-by user-code))

(defun find-wbs ()
  (mito:select-dao 'wbs))

(defgeneric add-child (parent child)
  (:method ((parent wbs) (child wbs))
    (create-wbs-structure parent child)))

(defun add-child-with-create (parent title &optional
                                             (description "")
                                             (user-code "renshi"))
  (let ((child (create-wbs title description user-code)))
    (add-child parent child)))
