(in-package :wnqi-big-size)

;;;;;
;;;;; Util
;;;;;
(defun timestamp2json (ts)
  (if (not ts)
      :null
      (local-time:format-timestring nil ts
                                    :format '((:YEAR 4) #\-
                                              (:MONTH 2) #\-
                                              (:DAY 2) #\T
                                              (:HOUR 2) #\:
                                              (:MIN 2) #\:
                                              (:SEC 2) #\.
                                              (:USEC 6) :gmt-offset-hhmm))))


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
    (jojo:write-key-value "_id"    (slot-value obj 'up:%id))
    (jojo:write-key-value "start"  (slot-value obj 'start))
    (jojo:write-key-value "_class" "EDGE")))

(defmethod jojo:%to-json ((obj edge-past))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "start" (slot-value obj 'start))
    (jojo:write-key-value "end"   (slot-value obj 'end))
    (jojo:write-key-value "_class" "EDGE-PAST")))


;;;;;
;;;;; Term
;;;;;
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
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "_class"      "PROJECT")))

(defmethod jojo:%to-json ((obj wbs))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "_class"      "WBS")))

(defmethod jojo:%to-json ((obj workpackage))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "_class"      "WORKPACKAGE")))

(defmethod jojo:%to-json ((obj artifact))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "_class"      "ARTIFACT")))
