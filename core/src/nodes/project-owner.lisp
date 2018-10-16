(in-package :wnqi-big-size)

(defun get-project-owner (graph &key code)
  (let ((results (find-vertex graph 'project-owner :slot 'code :value code)))
    (when (<= 2 (length results))
      (warn "複数存在します。 condition=~S" (list code)))
    (car results)))

(defun tx-make-project-owner (graph code &key name description)
  (let ((project-owner (get-project-owner graph :code code)))
    (or project-owner
        (tx-make-vertex graph 'project-owner
                        `((code ,code)
                          (name ,name)
                          (description ,description))))))
