#|
This file is a part of wnqi-big-size project.
Copyright (c) 2014 Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

(in-package :cl-user)
(defpackage wnqi-big-size-test
  (:nicknames :wbs-test)
  (:use :cl
        :5am
        :shinra
        :wbs))

(in-package :wnqi-big-size-test)



;;;;;
;;;;; Constant Variable
;;;;;
(defvar *pool* nil)
(defvar *pool-stor* nil)
(defvar *httpsvr* nil)
(defvar *http-port* 44444)
(defvar *http-log-dir* nil)
(defvar *http-lib-dir* nil)
(defvar *http-yzr-dir* nil)
(defvar *http-wbs-dir* nil)
(defvar *http-wbs-lib-dir* nil)
;; data
(defvar *incident* nil)
(defvar *request* nil)
(defvar *problem* nil)
(defvar *event* nil)
(defvar *root-wbs* nil)
(defvar *milestone-wbs* nil)
(defvar *object-wbs* nil)
(defvar *wbs-management* nil)

;;;;;
;;;;; test html
;;;;;
(defun yzr-common.css (request svr session)
  (declare (ignore svr session request))
  (setf (hunchentoot:content-type*) "text/css")
  (yzr:css :common))


(defun wbs-test.html (request svr session)
  (declare (ignore svr session request))
  (yzr:gen-html
      "WBS"
      ((:link :rel "stylesheet" :type "text/css" :href "/yzr/common.css")
       (:link :rel "stylesheet" :type "text/css" :href "/wbs.css")
       (:link :rel "stylesheet" :type "text/css" :href "/wbs/test.css"))
      ((:script :src "/lib/jquery/jquery-2.1.0.min.js")
       (:script :src "/lib/jquery/ui/1.10.4/js/jquery-ui-1.10.4.custom.min.js")
       (:script :src "/lib/moment/min/moment.min.js")
       ;; yzr
       (:script :src "/yzr/js/yaezakura.js")
       (:script :src "/yzr/js/yzrRequestCounter.js")
       (:script :src "/yzr/js/yzrAjax.js")
       (:script :src "/yzr/js/yzrCalendar.js")
       (:script :src "/yzr/js/yzrHtml.js")
       ;; yzr : comp
       (:script :src "/yzr/js/comp/TimeScale.js")
       (:script :src "/yzr/js/comp/TimeTable.js")
       (:script :src "/yzr/js/comp/yzrTimeTablePressure.js")
       (:script :src "/yzr/js/comp/yzrGunttchart.js")
       (:script :src "/yzr/js/comp/yzrTimeTableCounter.js")
       ;; org
       (:script :src "/wbs/lib/Wbs.js")
       (:script :src "/wbs/lib/Gunttchart.js")
       (:script :src "/wbs/lib/GunttchartModel.js")
       (:script :src "/wbs/test.js"))
    (:select :class "yzr" :id "itil-resources" :style "font-size:32px;")
    (:section :id "contents"
              (:div :id "guntt-chart"))))


(defun wbs-test.css (request svr session)
  (declare (ignore svr session request))
  (setf (hunchentoot:content-type*) "text/css")
  (cl-css:css
   `((h1 :font-size 32px :font-weight bold)
     (h2 :font-size 24px :font-weight bold)
     (h3 :font-size 16px :font-weight bold)
     (h2 :margin-top 22px)
     ("*" :margin 0px :padding 0px)
     (table :width 100%))))

(defun wbs-org.css (request svr session)
  (declare (ignore svr session request))
  (setf (hunchentoot:content-type*) "text/css")
  (wbs:wbs.css))


;;;;;
;;;;; rest-api
;;;;;
(defun get-tiile-rsc-list (request host session)
  (declare (ignore request host session))
  (list *incident* *request* *problem* *event*))

(defun get-top-wbs (request host session)
  (declare (ignore host session))
  (let ((id (tbnl:get-parameter "wbs" request)))
    (list (get-project-wbs *pool* (get-itil-resource *pool* id)))))


(defmethod get-wbs ((id string))
  (get-wbs (parse-integer id)))

(defmethod get-wbs ((id number))
  (first (remove nil
                 (mapcar #'(lambda (x) (up:get-object-with-id *pool* x id))
                         '(wbs project work-package milestone)))))

(defun get-wbs-childs (request host session)
  (declare (ignore host session))
  (let ((id (tbnl:get-parameter "wbs" request)))
    (let ((parent (get-wbs (parse-integer id))))
      (get-childs *pool* parent))))


;;;;;
;;;;; Start
;;;;;
;;
;; WBS
;;  |
;;  +-- マイルストーン
;;  |    |
;;  |    +-- レビュー
;;  |    |
;;  |    +-- サービスイン
;;  |
;;  +-- WBS
;;  |    |
;;  |    +-- 作る
;;  |    |
;;  |    +-- テスト
;;  |    |
;;  |    `-- サービスイン
;;  |
;;  `-- 管理
;;       |
;;       +-- 会議
;;       |
;;       `-- 報告
;;
(defun str-2-utime (str)
  (local-time:timestamp-to-universal (local-time:parse-timestring str)))

(defun start-shinra ()
  (setf *pool* (make-banshou 'banshou *pool-stor*))
  ;;
  (setf *incident* (make-incident *pool* "う○ち Big サイズ" "作るどぉ〜"))
  (setf *request*  (make-request *pool* "こんなんしてぇ〜" "こんなことや、あんなことまで"))
  (setf *problem*  (make-problem *pool* "人生上手くいきません。" "なんでじゃろ〜"))
  (setf *event*    (make-event *pool* "お腹のペコペコ具合を監視しとるんじゃけぇ" "そりゃぁ敏感いね。"))
  ;;
  (setf *root-wbs* (get-project-wbs *pool* *incident*))
  ;;
  (setf *milestone-wbs*
        (up:execute-transaction (tx-add-wbs *pool* *root-wbs* "マイルストーン" "test-1")))
  ;;
  (setf *object-wbs*
        (up:execute-transaction (tx-add-wbs *pool* *root-wbs* "オブジェクト"   "test-2")))
  ;;
  (setf *wbs-management*
        (up:execute-transaction (tx-add-wbs *pool* *root-wbs* "管理"           "test-3")))
  ;;
  (up:execute-transaction (tx-add-milestone *pool* *milestone-wbs*  "レビュー"       "test-4" (get-universal-time)))
  (up:execute-transaction (tx-add-milestone *pool* *milestone-wbs*  "サービス・イン" "test-5" (get-universal-time)))
  (up:execute-transaction (tx-add-wp *pool*
                                     *object-wbs*
                                     "作る" "test-6" "物"
                                     :plan (make-schedule "2014-07-13" "2014-07-15" 1.0 :hour)))
  (up:execute-transaction (tx-add-wp *pool*
                                     *object-wbs*
                                     "テスト" "test-7" "結果"
                                     :plan (make-schedule "2014-07-16" "2014-07-19" 2.5 :hour)
                                     :result (make-schedule "2014-07-17" "2014-07-20" 2.5 :hour)))
  (up:execute-transaction (tx-add-wp *pool*
                                     *object-wbs*
                                     "サービス・イン"
                                     "test-8"
                                     "打上げ"
                                     :plan (make-schedule "2014-07-20" "2014-07-21" 10.25 :hour)))
  (up:execute-transaction (tx-add-wbs       *pool* *wbs-management* "会議"           "test-9"))
  (up:execute-transaction (tx-add-wbs       *pool* *wbs-management* "報告"           "test-a"))

  (up:snapshot *pool*))

(defun start ()
  (start-shinra)
  (let ((httpsvr (yzr::make-rsc-server
                  :port      *http-port*
                  :log-dir   *http-log-dir*
                  :resources `(("/yzr/common.css" :get yzr-common.css)
                               ("/wbs.css"        :get wbs-org.css)
                               ("/wbs/test.html"  :get wbs-test.html)
                               ("/wbs/test.css"   :get wbs-test.css)
                               ("/rsc/wbs/top"    :get ,(yzr:defrsc 'get-top-wbs))
                               ("/rsc/wbs/childs" :get ,(yzr:defrsc 'get-wbs-childs))
                               ("/rsc/itil"       :get ,(yzr:defrsc 'get-tiile-rsc-list)))
                  :file-dirs `(("/lib/"     ,*http-lib-dir*)
                               ("/yzr/"     ,*http-yzr-dir*)
                               ("/wbs/"     ,*http-wbs-dir*)
                               ("/wbs/lib/" ,*http-wbs-lib-dir*)))))
    (yzr:start httpsvr)
    (setf *httpsvr* httpsvr)))

