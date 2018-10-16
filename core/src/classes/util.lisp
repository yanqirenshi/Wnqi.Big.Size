(in-package :wnqi-big-size)

(defun timestamp2json (ts)
  (if (not ts)
      :null
      (local-time:format-timestring nil ts
                                    :format '((:YEAR 4) #\-
                                              (:MONTH 2) #\-
                                              (:DAY 2) #\T
                                              (:HOUR 2) #\:
                                              (:MIN 2) #\:
                                              (:SEC 2) #\.
                                              (:USEC 6) :gmt-offset-hhmm))))
