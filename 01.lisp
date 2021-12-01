(defun deltas (input)
  (cdr
   (loop for i in input
         and j = 0 then i
         collect (if (> 0 (- j i))
                     1
                     0))))
;;; PART 1
(defvar input (mapcar #'parse-integer (uiop:read-file-lines "01.txt")))

(format t "Part 1: ~a~&" (reduce #'+ (deltas input)))

;;; PART 2
(defvar input2 (cdr (cdr
                  (loop for i in input
                        and j = 0 then i
                        and k = 0 then j
                        collect (+ k j i)))))

(format t "Part 2: ~a~&" (reduce #'+ (deltas input2)))
