(in-package :wnqi-big-size)

(defclass project-owner (node mutable)
  ((code :accessor code :initarg :code :initform nil)
   (name :accessor name :initarg :name :initform nil)))

(defmethod jojo:%to-json ((obj project-owner))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "_class"      "ARTIFACT")))
