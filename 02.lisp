(defvar input (mapcar #'uiop:split-string (uiop:read-file-lines "02.txt")))

(defun deltas ()
  (loop for i in input
        for horizontal = (if (equal (first i) "forward") (parse-integer (second i)) 0)
        for vertical = (cond ((equal (first i) "down") (parse-integer (second i)))
                             ((equal (first i) "up") (- (parse-integer (second i))))
                             (t 0))
        collect (list horizontal vertical)))

(defun part1 ()
  (apply #'* (reduce (lambda (acc i)
                       (list (+ (first acc) (first i))
                             (+ (second acc) (second i))))
                     (deltas))))

(defun part2 ()
  (apply #'* (reduce (let ((aim 0))
                       (lambda (acc i)
                         (incf aim (second i))
                         (list (+ (first acc) (first i))
                               (+ (second acc) (* aim (first i))))))
                     (deltas))))

(format t "Part 1: ~a~&Part 2: ~a~&" (part1) (part2))

;;; Initial raw version

(loop with horizontal-tot = 0
      with depth-tot = 0
      for i in input
      for horizontal = (if (equal (first i) "forward") (parse-integer (second i)) 0)
      for depth = (cond ((equal (first i) "down") (parse-integer (second i)))
                        ((equal (first i) "up") (- (parse-integer (second i))))
                        (t 0))
      do (incf horizontal-tot horizontal)
      do (incf depth-tot depth)
      finally (return (* horizontal-tot depth-tot)))

(loop with horizontal-tot = 0
      with aim-tot = 0
      with depth-tot = 0
      for i in input
      for horizontal = (if (equal (first i) "forward") (parse-integer (second i)) 0)
      for aim = (cond ((equal (first i) "down") (parse-integer (second i)))
                      ((equal (first i) "up") (- (parse-integer (second i))))
                      (t 0))
      do (incf horizontal-tot horizontal)
      do (incf aim-tot aim)
      do (incf depth-tot (* aim-tot horizontal))
      finally (return (* horizontal-tot depth-tot)))
