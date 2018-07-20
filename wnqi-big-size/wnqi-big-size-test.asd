#|
This file is a part of wnqi-big-size project.
Copyright (c) 2014 Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

(in-package :cl-user)
(defpackage wnqi-big-size-test-asd
  (:use :cl :asdf))

(in-package :wnqi-big-size-test-asd)

(defsystem wnqi-big-size-test
  :author "Satoshi Iwasaki"
  :license "LLGPL"
  :depends-on (:alexandria :wnqi-big-size :fiveam)
  :components ((:module "t"
                        :components
                        ((:file "wnqi-big-size"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
