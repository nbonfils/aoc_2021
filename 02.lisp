(defvar input (mapcar #'uiop:split-string (uiop:read-file-lines "02.txt")))

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
