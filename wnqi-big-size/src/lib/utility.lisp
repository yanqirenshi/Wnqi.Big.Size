(in-package :cl-user)
(defpackage wnqi-big-size.util
  (:nicknames :wbs.util)
  (:use :cl :alexandria :cl-ppcre)
  (:export #:fit-time
           #:trunc-utime
           #:timestamp2string))
(in-package :wnqi-big-size.util)


;;;;;
;;;;; utime
;;;;;
(defun fit-time (v)
  (cond ((null v) nil)
        ((numberp v) v)
        ((stringp v)
         (let ((tmp (local-time:parse-timestring v)))
           (unless tmp (error "なんじゃこりゃぁ!! value=~a" v))
           tmp))
        (t (error "なんじゃこりゃぁ!! value=~a" v))))


(defun trunc-utime (utime point)
  (multiple-value-bind (second minute hour date month year day daylight-p zone)
      (decode-universal-time utime)
    (declare (ignore second minute day daylight-p ))
    (cond ((eq :hour  point) (encode-universal-time 0 0 hour date month year zone))
          ((eq :date  point) (encode-universal-time 0 0 0    date month year zone))
          ((eq :month point) (encode-universal-time 0 0 0       1 month year zone))
          ((eq :year  point) (encode-universal-time 0 0 0       1     1 year zone))
          (t (error "この point は対応していません。point=~a" point)))))

(defun timestamp2string (timestamp)
  (when timestamp
    (local-time:format-timestring nil
                                  (local-time:timestamp+ timestamp 9 :hour)
                                  :format '((:YEAR 4) #\- (:MONTH 2) #\- (:DAY 2) #\Space (:HOUR 2) #\: (:MIN 2) #\: (:SEC 2)))))
