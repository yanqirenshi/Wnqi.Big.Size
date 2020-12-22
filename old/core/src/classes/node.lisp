(in-package :wnqi-big-size)

(defclass node (shinra:shin) ())

;; TODO: tree-node は適切ではないので、node-core とかにする。
(defclass tree-node (node mutable)
  ((name :accessor name :initarg :name :initform nil)
   (description :accessor description :initarg :description :initform nil)))
