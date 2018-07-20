(in-package :wbs)

(defclass action-start ()
  ((iid :accessor iid
        :initarg :iid
        :initform nil
        :col-type :serial
        :primary-key t)
   (action-code :col-type :integer
                :initarg :action-code
                :accessor action-code)
   (parson-code :col-type (:varchar 255)
                :initarg :parson-code
                :initform nil
                :accessor parson-code)
   (description :col-type :text
                :initarg :description
                :accessor description
                :initform "")
   (start-time :col-type :datetime
               :initarg :start-time
               :accessor start-time)
   (created-by :col-type (:varchar 255)
               :accessor created-by
               :initarg :created-by
               :initform nil)
   (updated-by :col-type (:varchar 255)
               :accessor updated-by
               :initarg :updated-by
               :initform nil))
  (:table-name "gtd.ev_action_start")
  (:metaclass mito:dao-table-class))

(defun create-action-start (action parson &key (description "") (creator "renshi"))
  (assert action)
  (mito:create-dao 'action-start
                   :action-code (action-code action)
                   :parson-code (parson-code parson)
                   :description description
                   :start-time (local-time:now)
                   :created-by (by creator)
                   :updated-by (by creator)))

(defun get-action-start (&key iid action parson)
  (cond (iid (car (mito:select-dao 'action-start (where (:= :iid iid)))))
        ((and action parson)
         (car (mito:select-dao 'action-start
                (where (:and (:= :parson-code (parson-code parson))
                             (:= :action-code (action-code action)))))))
        ((and (null action) parson)
         (car (mito:select-dao 'action-start
                (where (:= :parson-code (parson-code parson))))))))

(defun find-action-start (&key action-code)
  (cond (action-code
         (mito:select-dao 'action-start (where (:= :action-code action-code))))
        (t (mito:select-dao 'action-start))))
