(in-package :wnqi-big-size-api.render)

(defun render-json (object &key (status 200))
  (set-default-headers)
  (setf (caveman2:response-status caveman2:*response*)
        status)
  (jonathan:to-json object))
