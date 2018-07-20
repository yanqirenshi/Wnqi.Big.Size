(in-package :wnqi-big-size-api.controller)

(defun session-id ()
  (getf (getf (caveman2:request-env caveman2:*request*)
              :LACK.SESSION.OPTIONS)
        :id))

(defun eq-session-user (session-id user-code)
  (let ((data (gethash session-id caveman2:*session*)))
    (when (string= (getf data :user-code)
                   user-code)
      data)))

(defun save-user-in-session (session-id user-code)
  (setf (gethash session-id caveman2:*session*)
        (list :user-code user-code
              :auth-time (local-time:format-timestring nil (local-time:now)))))

;; (defun dalete-user-in-session (session-id user-code)
;;   (when (eq-session-user session-id user-code)
;;     (remhash session-id caveman2:*session*)))

(defun dalete-user-in-session (session-id user-code)
  (remhash session-id caveman2:*session*))

(defun auth-user (user-code)
  (let ((session-id (session-id)))
    (or (eq-session-user session-id user-code)
        (save-user-in-session session-id user-code))))

(defun session-user ()
  (let ((session (gethash (session-id) caveman2:*session*)))
    (when session
      (wbs::get-user :code (getf session :user-code)))))

(defun sign-in (post-data)
  (let ((user-code (getf post-data :|user_code|)))
    (if (and (wbs.controller::auth-user user-code)
             (wbs::get-user :code user-code))
        '(:status 200 :message "success!!!!")
        (error "Auth faild"))))

(defun sign-out (post-data)
  (let ((user-code (getf post-data :|user_code|)))
    (if (dalete-user-in-session (session-id) user-code)
        '(:status 200 :message "success!!!!")
        (error "Faild sign-out"))))
