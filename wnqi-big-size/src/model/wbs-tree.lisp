(in-package :wbs)

(defclass wbs-tree ()
  ((level :col-type :integer
          :accessor level
          :initarg :level
          :initform nil)
   (wbs-code-parent :col-type :integer
                    :accessor wbs-code-parent
                    :initarg :wbs-code-parent
                    :initform nil)
   (wbs-code :col-type :serial
             :initarg :wbs-code
             :initform nil
             :accessor wbs-code
             :primary-key t)
   (title :col-type (:varchar 255)
          :initarg :title
          :accessor title)
   (description :col-type :text
                :initarg :description
                :accessor description
                :initform "")
   (created-by :col-type (:varchar 255)
               :initarg :created-by
               :accessor created-by)
   (updated-by :col-type (:varchar 255)
               :initarg :updated-by
               :accessor updated-by))
  (:metaclass mito:dao-table-class))

(defun wbs-tree-sql ()
  (concatenate 'string
               "WITH RECURSIVE wbs_tree AS ( "
               "   SELECT 1 as level "
               "        , t1.* "
               "     FROM v_wbs_with_parent t1 "
               "    WHERE wbs_code = ? "
               "UNION ALL "
               "    SELECT parent.level + 1 as level "
               "         , child.* "
               "      FROM v_wbs_with_parent child "
               "         , wbs_tree AS parent "
               "     where child.wbs_code_parent = parent.wbs_code "
               ") "
               "select * from wbs_tree; "))

(defun plist2wbs-tree (plist)
  (let ((dao (make-instance 'wbs-tree
                            :level (getf plist :|level|)
                            :wbs-code-parent (getf plist :|wbs_code_parent|)
                            :wbs-code (getf plist :|wbs_code|)
                            :title (getf plist :|title|)
                            :description (getf plist :|description|)
                            ;; :|created_at| 3725413333
                            :created-by (getf plist :|created_by|)
                            ;; :|updated_at| 3725413333
                            :updated-by (getf plist :|updated_by|))))
    (setf (slot-value dao 'mito.dao.mixin::created-at)
          (int2timestamp (getf plist :|created_at|)))
    (setf (slot-value dao 'mito.dao.mixin::updated-at)
          (int2timestamp (getf plist :|updated_at|)))
    dao))

(defun %find-wbs-tree (result)
  (let ((row (dbi:fetch result)))
    (when row
      (cons (plist2wbs-tree row)
            (%find-wbs-tree result)))))

(defun find-wbs-tree (wbs)
  (let* ((con mito:*connection*)
         (result (dbi:execute (dbi:prepare con (wbs-tree-sql))
                              (wbs-code wbs))))
    (%find-wbs-tree result)))

(defun get-wbs-tree-root-sql ()
  (concatenate 'string
               " WITH RECURSIVE wbs_tree AS ( "
               "    SELECT 1 as level "
               "         , t1.* "
               "      FROM wbs.v_wbs_with_parent t1 "
               "     WHERE wbs_code = ? "
               "  UNION ALL "
               "    SELECT parent.level + 1 as level "
               "         , child.* "
               "      FROM wbs.v_wbs_with_parent child "
               "         , wbs_tree AS parent "
               "     where child.wbs_code = parent.wbs_code_parent "
               " ) "
               " select * "
               "   from wbs_tree "
               "  where wbs_code_parent is null;"))

(defun get-wbs-tree-root (wbs)
  (when wbs
    (let* ((con mito:*connection*)
           (result (dbi:execute (dbi:prepare con (get-wbs-tree-root-sql))
                                (wbs-code wbs))))
      (car (%find-wbs-tree result)))))
