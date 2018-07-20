(in-package :wnqi-big-size-api.controller)

;;;
;;; cockpit
;;;
(defun page-cockpit (user)
  (let ((parson (wbs::get-user-parson user))
        (lt (local-time:now)))
    (list :projects (wbs:find-project)
          :wbs (wbs::find-wbs)
          :activities (wbs:find-activity)
          :actions (wbs::find-action :parson parson)
          :action-histories (wbs::find-action-history :parson (wbs::get-parson :code 1)
                                                      :start (local-time:timestamp+ lt -1 :day)
                                                      :end lt)
          :action-start (or (wbs::get-action-start :parson parson)
                            :null)
          :buckets (wbs::find-bucket-active :parson parson))))

;;;
;;; projects
;;;
(defun page-projects-list (user)
  (let ((parson (wbs::get-user-parson user)))
    (declare (ignore parson))
    (wbs:find-project)))

(defun page-projects-unit (project-id)
  (let ((project (wbs:get-project :code project-id)))
    (list :project project
          :artifact (wbs:get-projects-artifact project)
          :wbs (wbs:find-wbs-tree (wbs:get-projects-wbs project)))))

(defun page-wbs (wbs-code)
  (let ((wbs (wbs:get-wbs :code wbs-code)))
    (list :project (wbs::get-project :wbs wbs)
          :wbs wbs
          :activities nil)))

(defun page-parsons ()
  (list :parsons (wbs::find-parson)))
