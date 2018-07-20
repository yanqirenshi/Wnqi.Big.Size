(in-package :wbs)

(defclass parson-bucket ()
  ((parson-code :accessor parson-code
                :initarg :parson-code
                :initform nil
                :col-type :integer)
   (bucket-code :accessor bucket-code
                :initarg :bucket-code
                :initform nil
                :col-type :integer)
   (created-by :col-type (:varchar 255)
               :initarg :created-by
               :accessor created-by)
   (updated-by :col-type (:varchar 255)
               :initarg :updated-by
               :accessor updated-by))
  (:table-name "gtd.ts_parson_bucket")
  (:metaclass mito:dao-table-class))

(defun get-parson-bucket (parson bucket)
  (mito:find-dao 'parson-bucket
                 :parson-code (parson-code parson)
                 :bucket-code (bucket-code bucket)))

(defun assert-bucket-has-parson (bucket)
  (assert
   (not (mito:find-dao 'parson-bucket :bucket-code (bucket-code bucket)))))

(defun assert-aledy-exit-relation (parson bucket)
  (assert
   (not (get-parson-bucket parson bucket))))

(defun assert-exist-parson-bucket (parson bucket)
  (assert
   (mito:find-dao 'parson-bucket
                  :parson-code (parson-code parson)
                  :bucket-code (bucket-code bucket))))

(defgeneric make-parson-bucket (parson bucket &key creator)
  (:method ((parson parson) (bucket bucket-active) &key creator)
    (assert-bucket-has-parson bucket)
    (assert-aledy-exit-relation parson bucket)
    (mito:create-dao 'parson-bucket
                     :parson-code (parson-code parson)
                     :bucket-code (bucket-code bucket)
                     :created-by (by creator)
                     :updated-by (by creator))))
