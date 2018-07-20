(in-package :cl-user)
(defpackage wnqi-big-size-api-test-asd
  (:use :cl :asdf))
(in-package :wnqi-big-size-api-test-asd)

(defsystem wnqi-big-size-api-test
  :author ""
  :license ""
  :depends-on (:wnqi-big-size-api
               :prove)
  :components ((:module "t"
                :components
                ((:file "wnqi-big-size-api"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
