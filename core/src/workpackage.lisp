(in-package :wnqi-big-size)

(defun get-workpackage (graph &key %id)
  (find-if #'(lambda (d) (= %id (%id d)))
           (find-vertex graph 'workpackage)))

(defun tx-make-workpackage (graph name &key description)
  (tx-make-vertex graph 'workpackage
                  `((name ,name)
                    (description ,description))))
