(in-package :wnqi-big-size-api.render)

(defun val-timestamp (obj slot)
  (let ((val (slot-value obj slot)))
    (if val
        (local-time:format-timestring nil val)
        :null)))

(defun val-string (obj slot)
  (let ((val (slot-value obj slot)))
    (or val :null)))

(defun val-integer (obj slot)
  (let ((val (slot-value obj slot)))
    (or val :null)))

(defmethod %to-json ((obj wbs::project))
  (with-object
    (write-key-value "project_code" (slot-value obj 'wbs::project-code))
    (write-key-value "name" (val-string obj 'wbs::name))
    (write-key-value "description" (val-string obj 'wbs::description))
    (write-key-value "created_by" (val-string obj 'wbs::created-by))
    (write-key-value "created_at" (val-timestamp obj 'mito.dao.mixin::created-at))
    (write-key-value "updated_by" (val-string obj 'wbs::updated-by))
    (write-key-value "updated_at" (val-timestamp obj 'mito.dao.mixin::updated-at))
    (write-key-value "_class" "project")))

(defmethod %to-json ((obj wbs::artifact))
  (with-object
    (write-key-value "artifact_code" (slot-value obj 'wbs::artifact-code))
    (write-key-value "name" (val-string obj 'wbs::name))
    (write-key-value "description" (val-string obj 'wbs::description))
    (write-key-value "created_by" (val-string obj 'wbs::created-by))
    (write-key-value "created_at" (val-timestamp obj 'mito.dao.mixin::created-at))
    (write-key-value "updated_by" (val-string obj 'wbs::updated-by))
    (write-key-value "updated_at" (val-timestamp obj 'mito.dao.mixin::updated-at))
    (write-key-value "_class" "artifact")))

(defmethod %to-json ((obj wbs::wbs))
  (with-object
    (write-key-value "wbs_code" (slot-value obj 'wbs::wbs-code))
    (write-key-value "title" (val-string obj 'wbs::title))
    (write-key-value "description" (val-string obj 'wbs::description))
    (write-key-value "created_by" (val-string obj 'wbs::created-by))
    (write-key-value "created_at" (val-timestamp obj 'mito.dao.mixin::created-at))
    (write-key-value "updated_by" (val-string obj 'wbs::updated-by))
    (write-key-value "updated_at" (val-timestamp obj 'mito.dao.mixin::updated-at))
    (write-key-value "_class" "wbs")))

(defmethod %to-json ((obj wbs::wbs-tree))
  (with-object
    (write-key-value "level" (val-integer obj 'wbs::level))
    (write-key-value "wbs_code_parent" (val-integer obj 'wbs::wbs-code-parent))
    (write-key-value "wbs_code" (val-integer obj 'wbs::wbs-code))
    (write-key-value "title" (val-string obj 'wbs::title))
    (write-key-value "description" (val-string obj 'wbs::description))
    (write-key-value "created_by" (val-string obj 'wbs::created-by))
    (write-key-value "created_at" (val-timestamp obj 'mito.dao.mixin::created-at))
    (write-key-value "updated_by" (val-string obj 'wbs::updated-by))
    (write-key-value "updated_at" (val-timestamp obj 'mito.dao.mixin::updated-at))
    (write-key-value "_class" "wbs-tree")))

(defmethod %to-json ((obj wbs::activity))
  (with-object
    (write-key-value "activity_code" (slot-value obj 'wbs::activity-code))
    (write-key-value "title" (val-string obj 'wbs::title))
    (write-key-value "description" (val-string obj 'wbs::description))
    (write-key-value "created_by" (val-string obj 'wbs::created-by))
    (write-key-value "created_at" (val-timestamp obj 'mito.dao.mixin::created-at))
    (write-key-value "updated_by" (val-string obj 'wbs::updated-by))
    (write-key-value "updated_at" (val-timestamp obj 'mito.dao.mixin::updated-at))
    (write-key-value "_class" "activity")))

(defmethod %to-json ((obj wbs::bucket-active))
  (with-object
    (write-key-value "bucket_code" (slot-value obj 'wbs::bucket-code))
    (write-key-value "name" (val-string obj 'wbs::name))
    (write-key-value "description" (val-string obj 'wbs::description))
    (write-key-value "bucket_type" (val-string obj 'wbs::bucket-type))
    (write-key-value "order_number" (val-string obj 'wbs::order-number))
    (write-key-value "status" :active)
    (write-key-value "created_by" (val-string obj 'wbs::created-by))
    (write-key-value "created_at" (val-timestamp obj 'wbs::created-at))
    (write-key-value "updated_by" (val-string obj 'wbs::updated-by))
    (write-key-value "updated_at" (val-timestamp obj 'wbs::updated-at))
    (write-key-value "_class" "bucket-active")))

(defmethod %to-json ((obj wbs::action-active))
  (with-object
    (write-key-value "action_code" (slot-value obj 'wbs::action-code))
    (write-key-value "description" (val-string obj 'wbs::description))
    (write-key-value "status" :active)
    (write-key-value "created_by" (val-string obj 'wbs::created-by))
    (write-key-value "created_at" (val-timestamp obj 'wbs::created-at))
    (write-key-value "updated_by" (val-string obj 'wbs::updated-by))
    (write-key-value "updated_at" (val-timestamp obj 'wbs::updated-at))
    (write-key-value "_class" "action-active")))

(defmethod %to-json ((obj wbs::action-archive))
  (with-object
    (write-key-value "action_code" (slot-value obj 'wbs::action-code))
    (write-key-value "description" (val-string obj 'wbs::description))
    (write-key-value "status" :archive)
    (write-key-value "created_by" (val-string obj 'wbs::created-by))
    (write-key-value "created_at" (val-timestamp obj 'wbs::created-at))
    (write-key-value "updated_by" (val-string obj 'wbs::updated-by))
    (write-key-value "updated_at" (val-timestamp obj 'wbs::updated-at))
    (write-key-value "_class" "action-active")))

(defmethod %to-json ((obj wbs::action))
  (with-object
    (write-key-value "action_code" (slot-value obj 'wbs::action-code))
    (write-key-value "bucket_code" (slot-value obj 'wbs::bucket-code))
    (write-key-value "description" (val-string obj 'wbs::description))
    (write-key-value "status" (slot-value obj 'wbs::status))
    (write-key-value "created_by" (val-string obj 'wbs::created-by))
    (write-key-value "created_at" (val-timestamp obj 'mito.dao.mixin::created-at))
    (write-key-value "updated_by" (val-string obj 'wbs::updated-by))
    (write-key-value "updated_at" (val-timestamp obj 'mito.dao.mixin::updated-at))
    (write-key-value "_class" "action")))

(defmethod %to-json ((obj wbs::action-start))
  (with-object
    (write-key-value "action_code" (slot-value obj 'wbs::action-code))
    (write-key-value "parson-code" (slot-value obj 'wbs::parson-code))
    (write-key-value "description" (val-string obj 'wbs::description))
    (write-key-value "created_by"  (val-string obj 'wbs::created-by))
    (write-key-value "created_at"  (val-timestamp obj 'mito.dao.mixin::created-at))
    (write-key-value "updated_by"  (val-string obj 'wbs::updated-by))
    (write-key-value "updated_at"  (val-timestamp obj 'mito.dao.mixin::updated-at))
    (write-key-value "_class" "action-start")))

(defmethod %to-json ((obj wbs::action-stop))
  (with-object
    (write-key-value "action_code" (slot-value obj 'wbs::action-code))
    (write-key-value "parson-code" (slot-value obj 'wbs::parson-code))
    (write-key-value "description" (val-string obj 'wbs::description))
    (write-key-value "created_by"  (val-string obj 'wbs::created-by))
    (write-key-value "created_at"  (val-timestamp obj 'wbs::created-at))
    (write-key-value "updated_by"  (val-string obj 'wbs::updated-by))
    (write-key-value "updated_at"  (val-timestamp obj 'wbs::updated-at))
    (write-key-value "_class" "action-stop")))

(defmethod %to-json ((obj wbs::action-history))
  (with-object
    (write-key-value "iid"          (slot-value obj 'wbs::iid))
    (write-key-value "action_code"  (slot-value obj 'wbs::action-code))
    (write-key-value "parson-code"  (slot-value obj 'wbs::parson-code))
    (write-key-value "parson_name"  (slot-value obj 'wbs::parson-name))
    (write-key-value "description"  (val-string obj 'wbs::description))
    (write-key-value "start_time"   (val-timestamp obj 'wbs::start-time))
    (write-key-value "end_time"     (val-timestamp obj 'wbs::end-time))
    (write-key-value "elapsed_time" (slot-value obj 'wbs::elapsed-time))
    (write-key-value "_class" "action-history")))


;;;
;;; organization
;;;
(defmethod %to-json ((obj wbs::parson))
  (with-object
    (write-key-value "created_by" (val-string obj 'wbs::created-by))
    (write-key-value "created_at" (val-timestamp obj 'mito.dao.mixin::created-at))
    (write-key-value "updated_by" (val-string obj 'wbs::updated-by))
    (write-key-value "updated_at" (val-timestamp obj 'mito.dao.mixin::updated-at))
    (write-key-value "_class" "parson")))
