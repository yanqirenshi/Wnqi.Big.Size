(in-package :wbs)

(defclass bucket ()
  ((bucket-code :primary-key t
                :col-type :integer
                :initarg :bucket-code
                :initform nil
                :accessor bucket-code)
   (name :col-type (:varchar 255)
         :initarg :name
         :accessor name
         :initform nil)
   (description :col-type :text
                :accessor description
                :initarg :description
                :initform "")
   (order_number :col-type :integer
                 :initarg :order_number
                 :accessor order_number
                 :initform nil)
   (bucket-type :col-type :integer
                :initarg :bucket-type
                :accessor bucket-type
                :initform nil)
   (status :col-type (:varchar 33)
                :accessor status
                :initarg :status
                :initform nil)
   (created-by :col-type (:varchar 255)
               :accessor created-by
               :initarg :created-by
               :initform nil)
   (created-at :col-type :timestamp
               :initarg :created-at
               :accessor created-at)
   (updated-by :col-type (:varchar 255)
               :accessor updated-by
               :initarg :updated-by
               :initform nil)
   (updated-at :col-type :timestamp
               :initarg :updated-at
               :initform nil
               :accessor updated-at))
  (:metaclass mito:dao-table-class))

(defun move-bucket (parson bucket-to action &key mover)
  (let ((bucket-now (get-bucket :action action)))
    (assert-exist-parson-bucket parson bucket-to)
    (assert-exist-parson-bucket parson bucket-now)
    (delete-bucket-action bucket-now action)
    (make-bucket-action bucket-to action :creator mover)))

;;;
;;; find bucket
;;;
(defun rec2bucket (rec)
  rec)

(defun find-bucket-at-parson-bucket-type-sql (type)
  (let ((table (cond ((eq :active type) :gtd.rs_bucket_active)
                     ((eq :archive type) :gtd.rs_bucket_archive)
                     (t (error "invalid type. type=~a " type)))))
    (select (:t2.*
             (:as :? :status))
      (from (:as :gtd.ts_parson_bucket :t1))
      (inner-join (:as table :t2)
                  :on (:= :t1.bucket_code :t2.bucket_code))
      (where (:and (:= :t1.parson_code :?)
                   (:= :t2.bucket_type :?))))))

(defun find-bucket-at-parson-bucket-type (parson bucket-type)
  (mapcar #'rec2bucket
          (nconc
           (retrieve (find-bucket-at-parson-bucket-type-sql :active)
                     (symbol-name :active)
                     (parson-code parson)
                     bucket-type)
           (retrieve (find-bucket-at-parson-bucket-type-sql :archive)
                     (symbol-name :archive)
                     (parson-code parson)
                     bucket-type))))

(defun find-bucket (&key parson bucket-type)
  (cond ((and parson bucket-type)
         (find-bucket-at-parson-bucket-type parson bucket-type))))
