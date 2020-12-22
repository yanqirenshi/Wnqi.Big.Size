(in-package :wnqi-big-size)

(defclass term (node immutable)
  ((start :accessor start :initarg :start :initform nil)
   (end :accessor end :initarg :end :initform nil)))

(defclass schedule (term) ())
(defclass result (term) ())

(defmethod jojo:%to-json ((obj schedule))
  (jojo:with-object
    (jojo:write-key-value "_id"    (slot-value obj 'up:%id))
    (jojo:write-key-value "start"  (timestamp2json (slot-value obj 'start)))
    (jojo:write-key-value "end"    (timestamp2json (slot-value obj 'end)))
    (jojo:write-key-value "_class" "SCHEDULE")))

(defmethod jojo:%to-json ((obj result))
  (jojo:with-object
    (jojo:write-key-value "_id"    (slot-value obj 'up:%id))
    (jojo:write-key-value "start"  (timestamp2json (slot-value obj 'start)))
    (jojo:write-key-value "end"    (timestamp2json (slot-value obj 'end)))
    (jojo:write-key-value "_class" "RESULT")))
