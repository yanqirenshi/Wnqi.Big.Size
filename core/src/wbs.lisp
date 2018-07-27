(in-package :wnqi-big-size)

(defun get-wbs (graph &key %id)
  (find-if #'(lambda (d) (= %id (%id d)))
           (find-vertex graph 'wbs)))

(defun tx-make-wbs (graph name &key description)
  (tx-make-vertex graph 'wbs
                  `((name ,name)
                    (description ,description))))
