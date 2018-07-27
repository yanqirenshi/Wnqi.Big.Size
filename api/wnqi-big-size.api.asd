#|
  This file is a part of wnqi-big-size.api project.
|#

(defsystem "wnqi-big-size.api"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "wnqi-big-size.api"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "wnqi-big-size.api-test"))))
