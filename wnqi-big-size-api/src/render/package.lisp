(in-package :cl-user)
(defpackage wnqi-big-size-api.render
  (:use :cl)
  (:nicknames #:wbs-api.render)
  (:import-from :caveman2
                #:*response*
                #:response-headers)
  (:import-from :jonathan
                #:%to-json
                #:with-object
                #:write-key-value)
  (:import-from :wnqi-big-size-api.config
                #:config)
  (:export #:render
           #:render-json
           #:*default-headers*))
(in-package :wnqi-big-size-api.render)
