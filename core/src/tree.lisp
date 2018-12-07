(in-package :wnqi-big-size)

;;;;;
;;;;; find-tree-node2plist
;;;;;
(defun term2plist (term)
  (if (not term)
      (list :|start| :null :|end| :null)
      (list :|start| (if (start term)
                         (local-time:format-timestring nil (start term))
                         :null)
            :|end|   (if (end term)
                         (local-time:format-timestring nil (end term))
                         :null))))

(defun find-tree-node-term (graph child type)
  (let ((class (class-name (class-of child))))
    (if (not (eq 'workpackage class))
        (term2plist nil)
        (cond ((eq :schedule type)
               (term2plist (get-schedule graph child)))
              ((eq :result type)
               (term2plist (get-result graph child)))))))

(defun %find-tree-node2plist (source &key code children schedule result)
  (list :|_id|         (up:%id source)
        :|code|        (or code (up:%id source))
        :|name|        (name source)
        :|description| (or (description source) :null)
        :|schedule|    (or schedule (list :|start| :null :|end| :null))
        :|result|      (or result   (list :|start| :null :|end| :null))
        :|children|    children
        :|_class|      (class-name (class-of source))))

(defgeneric find-tree-node2plist (graph node &key children)
  (:method (graph (source project) &key children)
    (declare (ignore graph))
    (%find-tree-node2plist source
                           :code (code source)
                           :children children))
  (:method (graph (source wbs) &key children)
    (declare (ignore graph))
    (%find-tree-node2plist source :children children))
  (:method (graph (source workpackage) &key children)
    (declare (ignore children))
    (%find-tree-node2plist source
                           :schedule (find-tree-node-term graph source :schedule)
                           :result   (find-tree-node-term graph source :result)))
  (:method (graph (edge edge) &key children)
    (declare (ignore graph children))
    (list :|_id|        (up:%id edge)
          :|from_class| (shinra::from-class edge)
          :|to_id|      (shinra::to-id edge)
          :|to_class|   (shinra::to-class edge)
          :|edge_type|  (shinra::edge-type edge))))

;;;;;
;;;;; find-tree-output-tree
;;;;;
;; (defun %find-tree-result (graph child)
;;   (let ((class (class-name (class-of child))))
;;     (if (not (eq 'workpackage class))
;;         (%find-tree-result2plist nil)
;;         (%find-tree-result2plist (get-result graph child)))))

(defun %find-tree-output-tree (graph children)
  (when-let ((child (car children)))
    ;; TODO: find-tree-node2plist を使うようにする。
    (cons (list :|_id|         (up:%id child)
                :|code|        (up:%id child)
                :|name|        (name child)
                :|description| (or (description child) :null)
                :|schedule|    (find-tree-node-term graph child :schedule)
                :|result|      (find-tree-node-term graph child :result)
                :|children|    (%find-tree-output-tree graph (find-children graph child))
                :|_class|      (class-name (class-of child)))
          (%find-tree-output-tree graph (cdr children)))))

(defgeneric find-tree-output-tree (graph project)
  (:method (graph (source project))
    ;; TODO: find-tree-node2plist を使うようにする。
    (list :|_id|         (up:%id source)
          :|code|        (code source)
          :|name|        (name source)
          :|description| (or (description source) :null)
          :|schedule|    (list :|start| :null :|end| :null)
          :|result|      (list :|start| :null :|end| :null)
          :|children|    (%find-tree-output-tree graph (find-children graph source))
          :|_class|      (class-name (class-of source))))
  (:method (graph (source wbs))
    ;; TODO: find-tree-node2plist を使うようにする。
    (list :|_id|         (up:%id source)
          :|code|        (up:%id source)
          :|name|        (name source)
          :|description| (or (description source) :null)
          :|schedule|    (list :|start| :null :|end| :null)
          :|result|      (list :|start| :null :|end| :null)
          :|children|    (%find-tree-output-tree graph (find-children graph source))
          :|_class|      (class-name (class-of source)))))

;;;;;
;;;;; find-tree-output-plist
;;;;;
(defmacro with-tree-node ((node tree-node-class) &body body)
  `(let ((tree-node (make-instance ,tree-node-class)))
     (setf (slot-value tree-node 'up:%id) (up:%id ,node))
     (setf (name tree-node)               (name ,node))
     (setf (description tree-node)        (description ,node))
     ,@body
     tree-node))

(defgeneric node2tree-node (graph node)
  (:method (graph (node workpackage))
    (with-tree-node (node 'workpackage-tree-node)
      (setf (schedule tree-node)           (get-schedule graph node))
      (setf (result tree-node)             (get-result graph node))))
  (:method (graph (node wbs))
    (declare (ignore graph))
    (with-tree-node (node 'wbs-tree-node)))
  (:method (graph (node project))
    (declare (ignore graph))
    (with-tree-node (node 'project-tree-node)))
  (:method (graph (node edge))
    (declare (ignore graph))
    node))

(defun %find-tree-node-children (graph parent-node child-class)
  (shinra:find-r graph 'edge
                 :from parent-node
                 :vertex-class child-class
                 :edge-type :have-to))

(defgeneric find-tree-node-children (graph parent-node)
  (:method (graph (parent-node project))
    (nconc (%find-tree-node-children graph parent-node 'wbs)
           (%find-tree-node-children graph parent-node 'workpackage)))
  (:method (graph (parent-node wbs))
    (nconc (%find-tree-node-children graph parent-node 'wbs)
           (%find-tree-node-children graph parent-node 'workpackage)))
  (:method (graph (parent-node workpackage))
    nil))

(defun find-tree-add-result (graph result data data-class)
  (let ((tree-node (node2tree-node graph data)))
    (if (null (gethash data-class result))
        (setf (gethash data-class result) (list tree-node))
        (setf (gethash data-class result) (cons tree-node (gethash data-class result))))))

(defun %find-tree-output-plist (graph project &optional (result (make-hash-table)))
  (let ((children (find-tree-node-children graph project)))
    (dolist (child-r children)
      (let* ((child (getf child-r :vertex))
             (r     (getf child-r :edge))
             (child-class (class-name (class-of child))))
        (when child
          (find-tree-add-result graph result child child-class)
          (find-tree-add-result graph result r     'edge)
          (%find-tree-output-plist graph child result)))))
  result)

(defun find-tree-output-plist (graph project)
  (let ((result (make-hash-table))
        (obj-class (class-name (class-of project))))
    (find-tree-add-result graph result project obj-class)
    (%find-tree-output-plist graph project result)))

;;;;;
;;;;; find-tree
;;;;;
(defun find-tree (graph start-node &key (output :plist))
  (cond ((eq output :plist) (find-tree-output-plist graph start-node))
        ((eq output :tree)  (find-tree-output-tree graph start-node))
        (t nil)))
