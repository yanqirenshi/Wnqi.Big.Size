(in-package :wbs)

(defclass action-history ()
  ((iid :accessor iid
        :initarg :iid
        :initform nil
        :col-type :integer
        :primary-key t)
   (action-code :col-type :integer
                :initarg :action-code
                :accessor action-code)
   (description :col-type :text
                :initarg :description
                :accessor description
                :initform "")
   (parson-code :col-type (:varchar 255)
                :initarg :parson-code
                :initform nil
                :accessor parson-code)
   (parson-name :col-type (:varchar 255)
                :initarg :parson-name
                :accessor parson-name)
   (start-time :col-type :datetime
               :initarg :start-time
               :accessor start-time)
   (end-time :col-type :datetime
             :initarg :end-time
             :accessor end-time)
   (elapsed-time :col-type :float
                 :initarg :elapsed-time
                 :accessor elapsed-time))
  (:record-timestamps nil)
  (:auto-pk nil)
  (:metaclass mito:dao-table-class))

(defun find-action-history-sql ()
  (select (:t1.iid
           :t1.action_code
           :t2.description
           :t1.parson_code
           (:as :t3.name :parson_name)
           :t1.start_time
           :t1.end_time
           (:as (:- :t1.end_time :t1.start_time) :elapsed_time))
    (from (:as :gtd.ev_action_stop :t1))
    (left-join (:as :gtd.rs_action_archive :t2)
               :on (:= :t1.action_code :t2.action_code))
    (left-join (:as :org.rs_parson :t3)
               :on (:= :t1.parson_code :t3.parson_code))
    (where (:and (:= :t1.parson_code :?)     ;; ex) 1
                 (:>= :t1.end_time :?)       ;;     '2018-02-14'
                 (:< :t1.start_time :?)))))  ;;     '2018-02-15'

(defun rec2action-hisotry (rec)
  (make-instance 'action-history
                 :iid          (getf rec :|iid|)
                 :action-code  (getf rec :|action_code|)
                 :parson-code  (getf rec :|parson_code|)
                 :parson-name  (getf rec :|parson_name|)
                 :description  (getf rec :|description|)
                 :start-time   (to-datetime (getf rec :|start_time|))
                 :end-time     (to-datetime (getf rec :|end_time|))
                 :elapsed-time (getf rec :|elapsed_time|)))

(defun find-action-history (&key parson start end)
  (mapcar #'rec2action-hisotry
          (retrieve (find-action-history-sql)
                    (by parson)
                    (to-datetime start)
                    (to-datetime end))))
