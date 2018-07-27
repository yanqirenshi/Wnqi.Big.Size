(in-package :wnqi-big-size)

;;;;;
;;;;; Base
;;;;;
(defclass immutable ()
  ((created-at :accessor created-at :initarg :created-at :initform (local-time:now))))

(defclass mutable (immutable)
  ((updated-at :accessor updated-at :initarg :updated-at :initform nil)))

(defclass node (shinra:shin) ())

(defclass edge (shinra:ra immutable)
  ((start :accessor start :initarg :start :initform nil)))
(defclass edge-past (edge)
  ((end :accessor end :initarg :end :initform nil)))


;;;;;
;;;;; Term
;;;;;
(defclass term (node immutable) (start end))
(defclass schedule (term) ())
(defclass result (term) ())


;;;;;
;;;;; Tree nodes
;;;;;
(defclass tree-node (node mutable)
  ((name :accessor name :initarg :name :initform nil)
   (description :accessor description :initarg :description :initform nil)))

(defclass project (tree-node)
  ((code :accessor code :initarg :code :initform nil)))

(defclass wbs (tree-node) ())

(defclass artifact (tree-node) ())
