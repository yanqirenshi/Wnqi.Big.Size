(in-package :wnqi-big-size)

(defclass estimate (node mutable)
  ((amount :accessor amount :initarg :amount :initform nil)
   (unit   :accessor unit   :initarg :unit   :initform nil)))

(defmethod jojo:%to-json ((obj artifact))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "_class"      "ARTIFACT")))
