(in-package :wnqi-big-size)

(defclass edge (shinra:ra immutable)
  ((start :accessor start :initarg :start :initform nil)))

(defmethod jojo:%to-json ((obj edge))
  (jojo:with-object
    (jojo:write-key-value "_id"        (slot-value obj 'up:%id))
    (jojo:write-key-value "from_id"    (slot-value obj 'shinra:from-id))
    (jojo:write-key-value "from_class" (slot-value obj 'shinra:from-class))
    (jojo:write-key-value "to_id"      (slot-value obj 'shinra:to-id))
    (jojo:write-key-value "to_class"   (slot-value obj 'shinra:to-class))
    (jojo:write-key-value "start"      (slot-value obj 'start))
    (jojo:write-key-value "_class" "EDGE")))


(defclass edge-past (edge)
  ((end :accessor end :initarg :end :initform nil)))

(defmethod jojo:%to-json ((obj edge-past))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "start" (slot-value obj 'start))
    (jojo:write-key-value "end"   (slot-value obj 'end))
    (jojo:write-key-value "_class" "EDGE-PAST")))
