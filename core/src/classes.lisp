(in-package :wnqi-big-size)

(defclass node (shinra:shin) (created-at updated-at))
(defclass edge (shinra:ra) (start))
(defclass edge-past (shinra:ra) (start end))

(defclass term (node) (start end))

(defclass project (node) (code name description))
(defclass wbs (node) (code name description))
(defclass artifact (node) (code name description))
