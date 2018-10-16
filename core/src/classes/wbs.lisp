(in-package :wnqi-big-size)

(defclass wbs (tree-node) ())

(defmethod jojo:%to-json ((obj wbs))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "_class"      "WBS")))


(defclass workpackage (tree-node) ())

(defmethod jojo:%to-json ((obj workpackage))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "_class"      "WORKPACKAGE")))


(defclass artifact (tree-node) ())

(defmethod jojo:%to-json ((obj artifact))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "_class"      "ARTIFACT")))


;;;;;
;;;;; Others
;;;;;
(defclass project-owner (node mutable)
  ((code :accessor code :initarg :code :initform nil)
   (name :accessor name :initarg :name :initform nil)))

(defclass resource (node mutable)
  ((code :accessor code :initarg :code :initform nil)
   (name :accessor name :initarg :name :initform nil)))

(defclass estimate (node mutable)
  ((amount :accessor amount :initarg :amount :initform nil)
   (unit   :accessor unit   :initarg :unit   :initform nil)))
