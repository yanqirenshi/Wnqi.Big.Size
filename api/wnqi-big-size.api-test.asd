#|
  This file is a part of wnqi-big-size.api project.
|#

(defsystem "wnqi-big-size.api-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("wnqi-big-size.api"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "wnqi-big-size.api"))))
  :description "Test system for wnqi-big-size.api"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
