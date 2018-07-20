(in-package :wbs)

(defclass bucket-active ()
  ((bucket-code :primary-key t
                :col-type :serial
                :initarg :bucket-code
                :initform nil
                :accessor bucket-code)
   (name :col-type (:varchar 255)
         :initarg :name
         :accessor name)
   (description :col-type :text
                :initarg :description
                :accessor description
                :initform "")
   (bucket-type :col-type :integer
                :initarg :bucket-type
                :accessor bucket-type
                :initform nil)
   (order-number :col-type :integer
                 :initarg :order-number
                 :accessor order-number
                 :initform nil)
   (created-by :col-type (:varchar 255)
               :initarg :created-by
               :accessor created-by)
   (created-at :col-type :timestamp
               :initarg :created-at
               :accessor created-at)
   (updated-by :col-type (:varchar 255)
               :initarg :updated-by
               :accessor updated-by)
   (updated-at :col-type :timestamp
               :initarg :updated-at
               :initform nil
               :accessor updated-at))
  (:table-name "gtd.rs_bucket_active")
  (:record-timestamps nil)
  (:metaclass mito:dao-table-class))

(defvar *in-box-name* "In-Box")

;;;
;;; get-bucket
;;;
(defun rec2bucket-active (rec)
  (when rec
    (record-2-dao-new rec 'bucket-active
                      :name (getf rec :|name|)
                      :bucket-code (getf rec :|bucket_code|)
                      :description (getf rec :|description|)
                      :bucket-type (getf rec :|bucket_type|)
                      :order-number (getf rec :|order_number|))))

(defun get-bucket-at-action (action)
  (let ((sql (select :t1.*
               (from (:as :gtd.rs_bucket_active :t1))
               (inner-join (:as :gtd.ts_bucket_action :t2)
                           :on (:= :t1.bucket_code :t2.bucket_code))
               (where (:= :t2.action_code :?)))))
    (rec2bucket-active
     (car (retrieve sql (action-code action))))))

(defun get-bucket (&key code action)
  (cond (code
         (mito:find-dao 'bucket-active :bucket-code code))
        (action
         (get-bucket-at-action action))))

;;;
;;; create-bucket
;;;
(defun create-bucket (name &key
                             (description "")
                             (bucket-type 0)
                             (order-number 10)
                             (creator -1))
  (mito:create-dao 'bucket-active
                   :name name
                   :description description
                   :bucket-type bucket-type
                   :order-number order-number
                   :created-by (by creator)
                   :created-at (local-time:now)
                   :updated-by (by creator)
                   :updated-at (local-time:now)))

;;;
;;; create-bucket-inbox
;;;
(defun create-bucket-inbox (&key (description "") (creator -1))
  (create-bucket *in-box-name*
                 :description description
                 :creator creator))

;;;
;;; finc-bucket-active
;;;
(defun find-bucket-active-sql ()
  (select :t2.*
    (from (:as :gtd.ts_parson_bucket :t1))
    (inner-join (:as :gtd.rs_bucket_active :t2)
                :on (:= :t1.bucket_code :t2.bucket_code))
    (where (:= :t1.parson_code :?))))

(defun %find-bucket-active (rec)
  (when rec
    (record-2-dao-new rec 'bucket-active
                      :bucket-code (getf rec :|bucket_code|)
                      :name (getf rec :|name|)
                      :description (getf rec :|description|)
                      :bucket-type (getf rec :|bucket_type|)
                      :order-number (getf rec :|order_number|))))

(defun find-bucket-active (&key parson)
  (cond ((and parson)
         (mapcar #'%find-bucket-active
                 (retrieve (find-bucket-active-sql)
                           (parson-code parson))))))

;;;
;;; get-bucket-inbox
;;;
(defun get-bucket-inbox-sql ()
  (select :t2.*
    (from (:as :gtd.ts_parson_bucket :t1))
    (inner-join (:as :gtd.rs_bucket_active :t2)
                :on (:= :t1.bucket_code :t2.bucket_code))
    (where (:and (:= :t1.parson_code :?)
                 (:= :t2.name :?)))))

(defun get-bucket-inbox (&key parson)
  (%find-bucket-active
   (car (retrieve (get-bucket-inbox-sql)
                  (parson-code parson)
                  *in-box-name*))))
