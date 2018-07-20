(in-package :wbs)

(defclass project-wbs ()
  ((project-code :col-type (:varchar 255)
                 :accessor project-code
                 :initarg :project-code)
   (wbs-code :col-type :integer
             :accessor wbs-code
             :initarg :wbs-code
             :initform nil)
   (created-by :col-type (:varchar 255)
               :accessor created-by
               :initarg :created-by)
   (updated-by :col-type (:varchar 255)
               :accessor updated-by
               :initarg :updated-by))
  (:table-name "wbs.ts_project_wbs")
  (:metaclass mito:dao-table-class))


(defun assert-wbs-have-not-project (wbs)
  (assert (not (mito:find-dao 'project-wbs
                              :wbs-code (wbs-code wbs)))))

(defun assert-project-have-not-wbs (project)
  (assert (not (mito:find-dao 'project-wbs
                              :project-code (project-code project)))))

(defun create-project-wbs (project wbs &key (user-code "renshi"))
  (assert-wbs-have-not-parent wbs)
  (assert-wbs-have-not-project wbs)
  (assert-project-have-not-wbs project)
  (mito:create-dao 'project-wbs
                   :project-code (project-code project)
                   :wbs-code (wbs-code wbs)
                   :created-by user-code
                   :updated-by user-code))

(defun get-projects-wbs (project)
  (let ((relationship (mito:find-dao 'project-wbs
                                     :project-code (project-code project))))
    (when relationship
      (get-wbs :code (wbs-code relationship)))))

(defun get-wbs-project (wbs)
  (when wbs
    (let ((r (mito:find-dao 'project-wbs
                            :wbs-code (wbs-code wbs))))
      (when r
        (get-project :code (project-code r))))))
