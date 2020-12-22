#|
  This file is a part of wnqi-big-size project.
|#

(defsystem "wnqi-big-size"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on (#:local-time
               #:jonathan
               #:shinrabanshou)
  :components ((:module "src"
                :components
                ((:file "package")
                 (:module "classes"
                  :components ((:file "util")
                               (:file "base")
                               (:file "node")
                               (:file "edge")
                               (:file "term")
                               (:file "project")
                               (:file "wbs")
                               (:file "workpackage")
                               (:file "artifact")
                               (:file "project-owner")
                               (:file "resource")
                               (:file "estimate")
                               (:file "product")))
                 (:module "nodes"
                  :components ((:file "project")
                               (:file "wbs")
                               (:file "workpackage")
                               (:file "estimate")
                               (:file "resource")
                               (:file "project-owner")))
                 (:file "children")
                 (:file "wbs_term")
                 (:file "owner_project")
                 (:file "project_term")
                 (:file "project_estimate")
                 ;; finder
                 (:file "finder")
                 (:file "tree"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "wnqi-big-size-test"))))
