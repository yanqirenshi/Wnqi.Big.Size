(in-package :wbs)

;;;;
;;;; create default buckets
;;;;
(defvar *default-in-box-names*
  '((:name "In-Box"         :type 1 :order 1)
    (:name "Next action"    :type 2 :order 2)
    (:name "Project"        :type 3 :order 3)
    (:name "Waiting for..." :type 4 :order 4)
    (:name "Someday/Maybe"  :type 5 :order 5)
    (:name "Cyclic"         :type 6 :order 6)
    (:name "Archive"        :type 7 :order 666)))

(defun create-default-buckets (parson &key (buckets-data *default-in-box-names*))
  (dolist (bucket-data buckets-data)
    (let ((type (getf bucket-data :type)))
      (unless (find-bucket :parson parson
                           :bucket-type type)
        (make-parson-bucket parson
                            (create-bucket (getf bucket-data :name)
                                           :description "auto created"
                                           :bucket-type type
                                           :order-number (getf bucket-data :order)
                                           :creator (by parson)))))))

;;;;
;;;; start-action
;;;;
(defun start-action (action parson)
  (let ((action-start (get-action-start :parson parson)))
    (when action-start
      (stop-action action-start parson)))
  (create-action-start action parson :creator (parson-code parson)))

;;;;
;;;; stop action
;;;;
(defgeneric stop-action (source parson)
  (:method ((action-start action-start) (parson parson))
    (mito:delete-dao action-start)
    (create-action-stop action-start :creator parson))
  (:method ((action action-active) (parson parson))
    (let ((action-start (get-action-start :parson parson :action action)))
      (assert action-start)
      (stop-action action-start parson))))

;;;;
;;;; archive-action
;;;;
(defun %archive-action (action parson)
  (mito:delete-dao action)
  ;; archive relation of bucket - archive
  (mito:create-dao 'action-archive
                   :action-code (action-code action)
                   :description (description action)
                   :created-at (created-at action)
                   :created-by (created-by action)
                   :updated-at (local-time:now)
                   :updated-by (by parson)))

(defun archive-action (action-code parson)
  (let ((active (get-action-active :code action-code :parson parson))
        (archive (get-action-archive :code action-code :parson parson))
        (action-starts (find-action-start :action-code action-code)))
    (when action-starts
      (dolist (action-start action-starts)
        (stop-action action-start parson)))
    (cond ((and active (null archive))
           (%archive-action active parson))
          ((and (null active) archive)
           archive)
          ((and (null active) (null archive))
           (error "Duplicate action. active=~a, archive=~a"
                  active archive)))))


;;;;;
;;;;; parson date history
;;;;;
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
