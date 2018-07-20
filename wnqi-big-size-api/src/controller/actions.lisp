(in-package :wnqi-big-size-api.controller)

(defun create-action (user params)
  (let* ((description (getf params :|description|))
         (parson (wbs:get-user-parson user))
         (bucket-inbox (wbs:get-bucket-inbox :parson parson)))
    (assert parson)
    (assert bucket-inbox)
    (let ((new_action (wbs:create-action-active description
                                                :parson parson)))
      (wbs:make-bucket-action bucket-inbox
                              new_action
                              :creator parson)
      (wbs:get-action :action new_action
                      :parson parson))))

(defun archive-action (user action-code)
  (wbs:archive-action action-code
                      (wbs:get-user-parson user)))

(defun start-action-action (user action-code)
  (let* ((parson (wbs:get-user-parson user))
         (action (wbs::get-action-active :code action-code :parson parson)))
    (assert parson)
    (assert action)
    (wbs:start-action action parson)))

(defun stop-action (user action-code)
  (let* ((parson (wbs:get-user-parson user))
         (action (wbs::get-action-active :code action-code :parson parson)))
    (assert parson)
    (assert action)
    (wbs::stop-action action parson)))
