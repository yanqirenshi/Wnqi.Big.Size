(in-package :wnqi-big-size)

;;;;;
;;;;; project
;;;;;
(defclass project (tree-node)
  ((code :accessor code :initarg :code :initform nil)))

(defmethod jojo:%to-json ((obj project))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "code"        (slot-value obj 'code))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "_class"      "PROJECT")))


;;;;;
;;;;; project-tree-node
;;;;;
(defclass project-tree-node (project)
  ((schedule :accessor schedule :initarg :schedule :initform nil)
   (result   :accessor result   :initarg :result   :initform nil)))

(defmethod jojo:%to-json ((obj project-tree-node))
  (jojo:with-object
    (jojo:write-key-value "_id"         (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "schedule"    (or (slot-value obj 'schedule) :null))
    (jojo:write-key-value "result"      (or (slot-value obj 'result)   :null))
    (jojo:write-key-value "_class"      "PROJECT")))
