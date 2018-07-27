#|
  This file is a part of wnqi-big-size.graph project.
|#

(defsystem "wnqi-big-size.graph-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("wnqi-big-size.graph"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "wnqi-big-size.graph"))))
  :description "Test system for wnqi-big-size.graph"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
