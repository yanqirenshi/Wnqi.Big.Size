(in-package :wbs)

(defclass project ()
  ((project-code :col-type (:varchar 255)
                 :initarg :project-code
                 :accessor project-code)
   (name :col-type (:varchar 255)
         :initarg :name
         :accessor name)
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
  (:table-name "wbs.rs_project")
  (:metaclass mito:dao-table-class))

(defun get-project (&key code _iid wbs)
  (cond (_iid (car (mito:select-dao 'project
                     (where (:= :_iid _iid)))))
        (code (mito:find-dao 'project :project-code code))
        (wbs (get-wbs-project (get-wbs-tree-root wbs)))))

(defun assert-not-exit-project-code (code)
  (let ((project (get-project :code code)))
    (when project
      (error "Already exit project. code=~a" project))))

(defun create-project (code name &optional (description "") (user-code "renshi"))
  (assert-not-exit-project-code code)
  (mito:create-dao 'project
                   :project-code code
                   :name name
                   :description description
                   :created-by user-code
                   :updated-by user-code))

(defun add-new-project (code name &key (description "") parson)
  (let ((created-at (parson-code parson)))
    (create-project-wbs
     (create-project code name description created-at)
     (create-wbs code)
     :user-code created-at)))

(defun find-project ()
  (mito:select-dao 'project))
