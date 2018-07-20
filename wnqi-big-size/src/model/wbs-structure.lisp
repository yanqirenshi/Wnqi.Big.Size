(in-package :wbs)

(defclass wbs-structure ()
  ((wbs-code-parent :col-type :integer
                    :initarg :wbs-code-parent
                    :accessor wbs-code-parent)
   (wbs-code-child :col-type :integer
                   :initarg :wbs-code-child
                   :accessor wbs-code-child)
   (created-by :col-type (:varchar 255)
               :initarg :created-by
               :accessor created-by)
   (updated-by :col-type (:varchar 255)
               :initarg :updated-by
               :accessor updated-by))
  (:table-name "wbs.rf_wbs")
  (:metaclass mito:dao-table-class))

(defun assert-wbs-have-not-parent (wbs)
  (assert (not (mito:find-dao 'wbs-structure
                              :wbs-code-child (wbs-code wbs)))))

(defun assert-exit-wbs-structure (parent child)
  (assert (not (mito:find-dao 'wbs-structure
                              :wbs-code-parent (wbs-code parent)
                              :wbs-code-child (wbs-code child)))))

(defun assert-exit-other-wbs-parent (parent child)
  (assert (not (mito:select-dao 'wbs-structure
                 (where (:and (:!= :wbs-code-parent (wbs-code parent))
                              (:= :wbs-code-child (wbs-code child))))))))

(defun create-wbs-structure (parent child &key (user-code "renshi"))
  (assert-exit-wbs-structure parent child)
  (assert-exit-other-wbs-parent parent child)
  (mito:create-dao 'wbs-structure
                   :wbs-code-parent (wbs-code parent)
                   :wbs-code-child (wbs-code child)
                   :created-by user-code
                   :updated-by user-code))
