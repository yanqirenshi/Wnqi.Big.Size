(in-package :wnqi-big-size-api.controller)

(defun move-action-2-bucket (user post-params bucket-code)
  (let* ((parson (wbs::get-user-parson user))
         (bucket-to (wbs::get-bucket :code bucket-code))
         (action (wbs::get-action-active :code (getf post-params :|action_code|)
                                         :parson parson)))
    (assert parson)
    (assert bucket-to)
    (assert action)
    (wbs::move-bucket parson bucket-to action :mover parson)
    action))
