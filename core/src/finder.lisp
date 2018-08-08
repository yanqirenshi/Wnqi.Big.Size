(in-package :wnqi-big-size)

(defun get-child-at-name (graph parent child-name class)
  (when parent
    (find-if #'(lambda (d)
                 (string= child-name (name d)))
             (shinra:find-r-vertex graph
                                   'edge
                                   :from parent
                                   :edge-type :have-to
                                   :vertex-class class))))

(defun get-child-wp-at-name (graph parent child-name)
  (get-child-at-name graph parent child-name 'workpackage))

(defun get-child-wbs-at-name (graph parent child-name)
  (get-child-at-name graph parent child-name 'wbs))


;;;;;
;;;;; find-reaf
;;;;;
(defgeneric find-reaf-wbs (graph parent &rest path)
  (:method (graph (parent project) &rest path)
    (when path
      (let ((wbs (get-child-wbs-at-name graph parent (car path))))
        (when wbs
          (apply #'find-reaf-wbs graph wbs (cdr path))))))
  (:method (graph (parent wbs) &rest path)
    (if (null path)
        parent
        (let ((wbs (get-child-wbs-at-name graph parent (car path))))
          (when wbs
            (apply #'find-reaf-wbs graph wbs (cdr path)))))))

(defgeneric find-reaf-workpackage (graph parent &rest path)
  (:method (graph (parent project) &rest path)
    (when path
      (let* ((wbs-path (reverse (cdr (reverse path))))
             (wbs (apply #'find-reaf-wbs graph parent wbs-path)))
        (when wbs
          (get-child-wp-at-name graph wbs (car (last path))))))))

(defun find-reaf (graph parent reaf-type &rest path)
  (cond ((eq :wbs reaf-type)
         (apply #'find-reaf-wbs         graph parent path))
        ((or (eq :wp reaf-type)
             (eq :workpackage reaf-type))
         (apply #'find-reaf-workpackage graph parent path))))
