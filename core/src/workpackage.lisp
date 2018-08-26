(in-package :wnqi-big-size)

(defun get-workpackage (graph &key %id)
  (find-if #'(lambda (d) (= %id (%id d)))
           (find-vertex graph 'workpackage)))

(defun %tx-make-workpackage (graph name description)
  (tx-make-vertex graph 'workpackage
                  `((name ,name)
                    (description ,description))))

(defun tx-make-workpackage (graph name &key description)
  (let ((wp (%tx-make-workpackage graph name description)))
    (tx-add-schedule graph wp nil nil)
    (tx-add-result graph wp nil nil)
    wp))
