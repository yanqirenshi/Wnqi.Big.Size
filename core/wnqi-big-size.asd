#|
  This file is a part of wnqi-big-size project.
|#

(defsystem "wnqi-big-size"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "wnqi-big-size"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "wnqi-big-size-test"))))
