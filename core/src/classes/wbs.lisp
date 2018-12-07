(in-package :wnqi-big-size)

;;;;;
;;;;; wbs
;;;;;
(defclass wbs (tree-node) ())

(defmethod jojo:%to-json ((obj wbs))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "_class"      "WBS")))


;;;;;
;;;;; wbs-tree-node
;;;;;
(defclass wbs-tree-node (wbs)
  ((schedule :accessor schedule :initarg :schedule :initform nil)
   (result   :accessor result   :initarg :result   :initform nil)))

(defmethod jojo:%to-json ((obj wbs-tree-node))
  (jojo:with-object
    (jojo:write-key-value "_id"         (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "schedule"    (or (slot-value obj 'schedule) :null))
    (jojo:write-key-value "result"      (or (slot-value obj 'result)   :null))
    (jojo:write-key-value "_class"      "WBS")))
