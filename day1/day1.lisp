;;; PART 1
(reduce #'+ (cdr
             (loop for i in (uiop:read-file-lines "input")
                   and j = "0" then i
                   collect (if (> 0 (- (parse-integer j)(parse-integer i)))
                               1
                               0))))
;;; PART 2
(let ((summed-list (cdr (cdr
                         (loop for i in (uiop:read-file-lines "input")
                               and j = "0" then i
                               and k = "0" then j
                               collect (+ (parse-integer k)(parse-integer j)(parse-integer i)))))))
  (reduce #'+ (cdr
               (loop for i in summed-list
                     and j = 0 then i
                     collect (if (> 0 (- j i))
                                 1
                                 0)))))
