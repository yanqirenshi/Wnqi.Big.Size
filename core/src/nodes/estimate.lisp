(in-package :wnqi-big-size)

(defun get-estimate (graph &key code)
  (let ((results (find-vertex graph 'estimate :slot 'code :value code)))
    (when (<= 2 (length results))
      (warn "複数存在します。 condition=~S" (list code)))
    (car results)))

(defun tx-make-estimate (graph code &key name description)
  (let ((estimate (get-estimate graph :code code)))
    (or estimate
        (tx-make-vertex graph 'estimate
                        `((code ,code)
                          (name ,name)
                          (description ,description))))))
