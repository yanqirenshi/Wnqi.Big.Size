(in-package :wnqi-big-size)


(defun %get-child (graph parent child)
  (car (find-if #'(lambda (d) (= (%id child)
                                 (%id (getf d :vertex))))
                (shinra:find-r graph 'edge :from parent
                                           :vertex-class (class-name (class-of child))
                                           :edge-type :have-to))))

(defgeneric get-child (graph parent child)
  (:method (graph (parent project)     (child wbs))         (%get-child graph parent child))
  (:method (graph (parent wbs)         (child wbs))         (%get-child graph parent child))
  (:method (graph (parent wbs)         (child workpackage)) (%get-child graph parent child))
  (:method (graph (parent workpackage) (child artifact))    (%get-child graph parent child)))



(defun %tx-add-child (graph parent child)
  (or (get-child graph parent child)
      (shinra:tx-make-edge graph 'edge parent child :have-to)))

(defgeneric tx-add-child (graph parent child)
  (:method tx-add-child (graph (parent project)     (child wbs))         (%tx-add-child graph parent child))
  (:method tx-add-child (graph (parent wbs)         (child wbs))         (%tx-add-child graph parent child))
  (:method tx-add-child (graph (parent wbs)         (child workpackage)) (%tx-add-child graph parent child))
  (:method tx-add-child (graph (parent workpackage) (child artifact))    (%tx-add-child graph parent child)))
