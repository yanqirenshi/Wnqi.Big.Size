(in-package :cl-user)
(defpackage wnqi-big-size-api-asd
  (:use :cl :asdf))
(in-package :wnqi-big-size-api-asd)

(defsystem wnqi-big-size-api
  :version "0.1"
  :author ""
  :license ""
  :depends-on (:clack
               :lack
               :caveman2
               :envy
               :cl-ppcre
               :uiop
               :lack-session-store-dbi
               :lack-middleware-validation
               :jonathan
               ;; Database
               :upanishad
               :shinrabanshou
               :sephirothic)
  :components ((:module "src"
                :components
                ((:file "config")
                 (:module "controller"
                  :components ((:file "package")
                               (:file "auth")
                               (:file "page")
                               (:file "actions")
                               (:file "buckets")))
                 (:module "render"
                  :components ((:file "package")
                               (:file "to-json")
                               (:file "header")
                               (:file "render")))
                 (:module "router"
                  :components ((:file "util")
                               (:file "route")
                               (:file "api-v1")
                               (:file "api-v1-projects")
                               (:file "api-v1-wbs")
                               (:file "api-v1-activities")
                               (:file "api-v1-actions")
                               (:file "api-v1-buckets")
                               (:file "api-v1-pages")
                               (:file "api-v1-sign")))
                 (:file "main"))))
  :description ""
  :in-order-to ((test-op (load-op wnqi-big-size-api-test))))
