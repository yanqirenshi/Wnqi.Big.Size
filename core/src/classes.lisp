(in-package :wnqi-big-size)

;;;;;
;;;;; Base
;;;;;
(defclass node (shinra:shin) (created-at updated-at))
(defclass edge (shinra:ra) (start))
(defclass edge-past (shinra:ra) (start end))


;;;;;
;;;;; Term
;;;;;
(defclass term (node) (start end))


;;;;;
;;;;; Tree nodes
;;;;;
(defclass tree-node (node)
  ((name :accessor name :initarg :name :initform nil)
   (description :accessor description :initarg :description :initform nil)))

(defclass project (tree-node)
  ((code :accessor code :initarg :code :initform nil)))

(defclass wbs (tree-node) ())

(defclass artifact (tree-node) ())
