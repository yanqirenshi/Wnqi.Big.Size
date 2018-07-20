(in-package :wnqi-big-size-api.render)

(defvar *default-headers*
  `(:content-type "application/json"
    :access-control-allow-credentials "true"
    :access-control-allow-origin ,(or (config :http :response :header :access-control-allow-origin)
                                      "http://localhost")))

(defun set-response-header (key)
  (setf (getf (response-headers *response*) key)
        (getf *default-headers*  key)))

(defun set-default-headers ()
  (set-response-header :content-type)
  (set-response-header :access-control-allow-credentials)
  (set-response-header :access-control-allow-origin))
