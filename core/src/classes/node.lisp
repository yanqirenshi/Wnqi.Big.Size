(in-package :wnqi-big-size)

(defclass node (shinra:shin) ())

(defclass tree-node (node mutable)
  ((name :accessor name :initarg :name :initform nil)
   (description :accessor description :initarg :description :initform nil)))
