(in-package :wbs)

(defclass bucket-archive ()
  ((bucket-code :accessor bucket-code
                :initarg :bucket-code
                :initform nil
                :primary-key t
                :col-type :integer)
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
  (:table-name "gtd.rs_bucket_archive")
  (:record-timestamps nil)
  (:metaclass mito:dao-table-class))
