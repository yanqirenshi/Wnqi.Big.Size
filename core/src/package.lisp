(defpackage wnqi-big-size
  (:nicknames :wbs)
  (:use #:cl)
  (:import-from :upanishad
                #:%id)
  (:import-from :shinra
                #:find-vertex
                #:tx-make-vertex
                #:tx-make-edge)
  (:export #:tx-make-project
           #:get-project)
  (:export #:tx-make-wbs
           #:get-wbs)
  (:export #:get-workpackage
           #:tx-make-workpackage)
  (:export #:tx-add-child
           #:get-child))
(in-package :wnqi-big-size)
