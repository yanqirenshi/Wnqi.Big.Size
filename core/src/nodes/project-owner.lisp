(in-package :wnqi-big-size)

(defun find-project-owners (graph)
  (find-vertex graph 'project-owner))

(defun get-project-owner-at-code (graph code)
  (let ((results (find-vertex graph 'project-owner :slot 'code :value code)))
    (when (<= 2 (length results))
      (warn "複数存在します。 condition=~S" (list code)))
    (car results)))

(defun get-project-owner-at-name (graph name)
  (let ((results (find-vertex graph 'project-owner :slot 'name :value name)))
    (print results)
    (when (<= 2 (length results))
      (warn "複数存在します。 condition=~S" (list name)))
    (car results)))

(defun get-project-owner (graph &key code name)
  (cond (code (get-project-owner-at-code graph code))
        (name (get-project-owner-at-name graph name))))

(defun tx-make-project-owner (graph code &key name)
  (let ((project-owner (get-project-owner graph :code code)))
    (or project-owner
        (tx-make-vertex graph 'project-owner
                        `((code ,code)
                          (name ,name))))))
