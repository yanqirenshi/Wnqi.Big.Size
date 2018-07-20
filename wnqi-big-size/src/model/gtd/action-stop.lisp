(in-package :wbs)

(defclass action-stop ()
  ((iid :col-type :integer
        :accessor iid
        :initarg :iid
        :initform nil
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
   (end-time :col-type :datetime
             :initarg :end-time
             :accessor end-time)
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
  (:table-name "gtd.ev_action_stop")
  (:record-timestamps nil)
  (:auto-pk nil)
  (:metaclass mito:dao-table-class))

(defun create-action-stop (action &key (description "") (creator "renshi"))
  (mito:create-dao 'action-stop
                   :iid (iid action)
                   :action-code (action-code action)
                   :parson-code (parson-code action)
                   :description description
                   :start-time (start-time action)
                   :end-time (local-time:now)
                   :created-by (created-by action)
                   :created-at (slot-value action 'mito.dao.mixin::created-at)
                   :updated-by (parson-code creator)
                   :updated-at (local-time:now)))
