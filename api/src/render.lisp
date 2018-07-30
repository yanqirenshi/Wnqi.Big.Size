(in-package :cl-user)
(defpackage wnqi-big-size.api.render
  (:use :cl)
  (:import-from #:caveman2
                #:*response*
                #:response-headers)
  (:export #:render
           #:render-json))
(in-package :wnqi-big-size.api.render)

(defun set-header (response key value)
  (setf (getf (response-headers response) key)
        value))

(defun render-json (object)
  (set-header *response* :content-type "application/json")
  (set-header *response* :access-control-allow-origin "http://localhost")
  (set-header *response* :access-control-allow-credentials "true")
  (jonathan:to-json object))
