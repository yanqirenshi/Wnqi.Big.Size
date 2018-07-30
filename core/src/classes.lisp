(in-package :wnqi-big-size)

;;;;;
;;;;; Base
;;;;;
(defclass immutable ()
  ((created-at :accessor created-at :initarg :created-at :initform (local-time:now))))

(defclass mutable (immutable)
  ((updated-at :accessor updated-at :initarg :updated-at :initform nil)))

;;; node
(defclass node (shinra:shin) ())

;;; edge
(defclass edge (shinra:ra immutable)
  ((start :accessor start :initarg :start :initform nil)))

(defclass edge-past (edge)
  ((end :accessor end :initarg :end :initform nil)))

(defmethod jojo:%to-json ((obj edge))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "start" (slot-value obj 'start))))

(defmethod jojo:%to-json ((obj edge-past))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "start" (slot-value obj 'start))
    (jojo:write-key-value "end"   (slot-value obj 'end))))



;;;;;
;;;;; Term
;;;;;
(defclass term (node immutable) (start end))
(defclass schedule (term) ())
(defclass result (term) ())

(defmethod jojo:%to-json ((obj term))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "start" (slot-value obj 'start))
    (jojo:write-key-value "end"   (slot-value obj 'end))))


;;;;;
;;;;; Tree nodes
;;;;;
(defclass tree-node (node mutable)
  ((name :accessor name :initarg :name :initform nil)
   (description :accessor description :initarg :description :initform nil)))

(defclass project (tree-node)
  ((code :accessor code :initarg :code :initform nil)))

(defclass wbs (tree-node) ())

(defclass workpackage (tree-node) ())

(defclass artifact (tree-node) ())

(defmethod jojo:%to-json ((obj project))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "code"        (slot-value obj 'code))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (slot-value obj 'description))))

(defmethod jojo:%to-json ((obj wbs))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (slot-value obj 'description))))

(defmethod jojo:%to-json ((obj workpackage))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (slot-value obj 'description))))

(defmethod jojo:%to-json ((obj artifact))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (slot-value obj 'description))))
