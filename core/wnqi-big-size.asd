#|
  This file is a part of wnqi-big-size project.
|#

(defsystem "wnqi-big-size"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on (#:shinrabanshou)
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "classes")
                 ;; project
                 (:file "project")
                 (:file "project-term")
                 (:file "project-wbs")
                 (:file "project-artifact")
                 ;; wbs
                 (:file "wbs")
                 (:file "wbs-structure")
                 (:file "wbs-artifact")
                 (:file "wbs-term"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "wnqi-big-size-test"))))
