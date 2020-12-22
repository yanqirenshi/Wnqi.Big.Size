(in-package :wnqi-big-size)

(defun find-resource (graph)
  (find-vertex graph 'resource))

(defun get-resource (graph &key code)
  (let ((results (find-vertex graph 'resource :slot 'code :value code)))
    (when (<= 2 (length results))
      (warn "複数存在します。 condition=~S" (list code)))
    (car results)))

(defun tx-make-resource (graph code &key name)
  (let ((resource (get-resource graph :code code)))
    (or resource
        (tx-make-vertex graph 'resource
                        `((code ,code)
                          (name ,name))))))
