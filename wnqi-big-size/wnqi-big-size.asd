#|
This file is a part of wnqi-big-size project.
Copyright (c) 2014 Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

#|
Author: Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

(in-package :cl-user)
(defpackage wnqi-big-size-asd
  (:use :cl :asdf))
(in-package :wnqi-big-size-asd)

(defsystem wnqi-big-size
  :version "0.1"
  :author "Satoshi Iwasaki"
  :license "LLGPL"
  :depends-on (:alexandria
               :cl-ppcre
               :local-time
               :mito)
  :components ((:module "src"
                :components ((:file "db")
                             (:module "lib"
                              :components ((:file "utility")))
                             (:file "package")
                             (:module "model/account"
                              :components ((:file "user")))
                             (:module "model/org"
                              :components ((:file "parson")
                                           (:file "user-parson")))
                             (:module "model/gtd"
                              :components ((:file "action-active")
                                           (:file "action-archive")
                                           (:file "action-start")
                                           (:file "action-stop")
                                           (:file "action")
                                           (:file "bucket-active")
                                           (:file "bucket-archive")
                                           (:file "bucket-action")
                                           (:file "parson-bucket")
                                           (:file "bucket")
                                           (:file "action-history")
                                           (:file "gtd")))
                             (:module "model"
                              :components ((:file "util")
                                           (:file "activity")
                                           (:file "wbs")
                                           (:file "wbs-structure")
                                           (:file "wbs-tree")
                                           (:file "artifact")
                                           (:file "project")
                                           (:file "project-wbs")
                                           (:file "project-artifact"))))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op wnqi-big-size-test))))
