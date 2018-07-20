(ql:quickload :wnqi-big-size-api)

(defpackage wnqi-big-size-api.app
  (:use #:cl
        #:wnqi-big-size-api.api-v1-projects
        #:wnqi-big-size-api.api-v1-wbs
        #:wnqi-big-size-api.api-v1-activities
        #:wnqi-big-size-api.api-v1-actions
        #:wnqi-big-size-api.api-v1-buckets
        #:wnqi-big-size-api.api-v1-pages
        #:wnqi-big-size-api.api-v1-sign
        #:wnqi-big-size-api.api-v1
        #:wnqi-big-size-api.router)
  (:import-from :lack.builder
                #:builder)
  (:import-from :ppcre
                #:scan
                #:regex-replace)
  (:import-from :lack.middleware.session.store.dbi
                #:make-dbi-store)
  (:import-from :wnqi-big-size-api.config
                #:config)
  (:import-from :wnqi-big-size-api.render
                #:*default-headers*))
(in-package :wnqi-big-size-api.app)

(defun path (path)
  (concatenate 'string
               (or (config :api  :path :prefix) "")
               path))

(builder
 :accesslog
 (if (config :log :error :directory)
     `(:backtrace
       :output ,(config :log :error :directory))
     nil)
 (:session
  :store (make-dbi-store :connector
                         (lambda ()
                           (dbi:connect :mysql
                                        :database-name "lack_session"
                                        :username "root"
                                        :password "root"))))
 (:validation :header *default-headers*)
 (:mount (path "/api/v1/projects") *api-v1-projects*)
 (:mount (path "/api/v1/wbs") *api-v1-wbs*)
 (:mount (path "/api/v1/activities") *api-v1-activities*)
 (:mount (path "/api/v1/actions") *api-v1-actions*)
 (:mount (path "/api/v1/buckets") *api-v1-buckets*)
 (:mount (path "/api/v1/pages") *api-v1-pages*)
 (:mount (path "/api/v1/sign") *api-v1-sign*)
 (:mount (path "/api/v1") *api-v1*)
 *route*)
