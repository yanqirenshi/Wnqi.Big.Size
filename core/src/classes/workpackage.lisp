(in-package :wnqi-big-size)

(defclass workpackage (tree-node) ())

(defmethod jojo:%to-json ((obj workpackage))
  (jojo:with-object
    (jojo:write-key-value "_id"   (slot-value obj 'up:%id))
    (jojo:write-key-value "name"        (slot-value obj 'name))
    (jojo:write-key-value "description" (or (slot-value obj 'description) ""))
    (jojo:write-key-value "_class"      "WORKPACKAGE")))
