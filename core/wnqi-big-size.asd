#|
  This file is a part of wnqi-big-size project.
|#

(defsystem "wnqi-big-size"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on (#:local-time
               #:shinrabanshou)
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "classes")
                 (:file "children")
                 ;; project
                 (:file "project")
                 (:file "project-term")
                 ;; wbs
                 (:file "wbs")
                 (:file "wbs-term")
                 ;; workpackage
                 (:file "workpackage")
                 ;; finder
                 (:file "finder"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "wnqi-big-size-test"))))
