(in-package :wbs)

(defclass project-artifact ()
  ((project-code :col-type (:varchar 255)
                 :accessor project-code
                 :initarg :project-code)
   (artifact-code :col-type :integer
                  :accessor artifact-code
                  :initarg :artifact-code
                  :initform nil)
   (created-by :col-type (:varchar 255)
               :accessor created-by
               :initarg :created-by)
   (updated-by :col-type (:varchar 255)
               :accessor updated-by
               :initarg :updated-by))
  (:table-name "wbs.ts_project_artifact")
  (:metaclass mito:dao-table-class))

(defun create-project-artifact (project artifact &key (user-code "renshi"))
  (mito:create-dao 'project-artifact
                   :project-code (project-code project)
                   :artifact-code (artifact-code artifact)
                   :created-by user-code
                   :updated-by user-code))

(defun get-projects-artifact (project)
  (let ((relationships (mito:select-dao 'project-artifact
                         (where (:= :project-code (project-code project))))))
    (when relationships
      (mapcar #'(lambda (relationship)
                  (get-artifact :code (artifact-code relationship)))
              relationships))))
