#|
  This file is a part of wnqi-big-size project.
|#

(defsystem "wnqi-big-size-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("wnqi-big-size"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "wnqi-big-size"))))
  :description "Test system for wnqi-big-size"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
