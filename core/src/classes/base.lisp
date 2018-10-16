(in-package :wnqi-big-size)

(defclass immutable ()
  ((created-at :accessor created-at :initarg :created-at :initform (local-time:now))))

(defclass mutable (immutable)
  ((updated-at :accessor updated-at :initarg :updated-at :initform nil)))
