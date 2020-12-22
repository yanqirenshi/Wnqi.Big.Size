(in-package :wnqi-big-size)

(defun get-project (graph &key code)
  (let ((results (find-vertex graph 'project :slot 'code :value code)))
    (when (<= 2 (length results))
      (warn "複数存在します。 condition=~S" (list code)))
    (car results)))

(defun tx-make-project (graph code &key name description)
  (let ((project (get-project graph :code code)))
    (or project
        (tx-make-vertex graph 'project
                        `((code ,code)
                          (name ,name)
                          (description ,description))))))
