(in-package :cl-user)
(defpackage wnqi-big-size-api
  (:use :cl)
  (:nicknames :wbs.api)
  (:import-from #:wnqi-big-size-api.config
                #:config)
  (:import-from #:clack
                #:clackup)
  (:export #:start
           #:stop))
(in-package :wnqi-big-size-api)

(defvar *appfile-path*
  (asdf:system-relative-pathname :wnqi-big-size-api #P"src/app.lisp"))

(defvar *handler* nil)

(defun start (&rest args &key
                           (server (config :http :server :type))
                           (port (config :http :server :port))
                           debug &allow-other-keys)
  (declare (ignore debug))
  (unless server (error "(config :http :server :type) is nil"))
  (unless port (error "(config :http :server :port) is nil"))
  (when *handler*
    (restart-case (error "Server is already running.")
      (restart-server ()
        :report "Restart the server"
        (stop))))
  (setf *handler*
        (apply #'clackup *appfile-path* :server server :port port args)))

(defun stop ()
  (prog1
      (clack:stop *handler*)
    (setf *handler* nil)))
