(ql:quickload "split-sequence")
(ql:quickload "alexandria")

(defparameter input (uiop:read-file-lines "04.txt"))
(defparameter random-num (mapcar #'parse-integer (uiop:split-string (car input) :separator ",")))

(defparameter cards (mapcar (lambda (x) (mapcar (lambda (y) (mapcar #'parse-integer (remove-if (lambda (z) (equal z "")) y))) (mapcar #'uiop:split-string x))) (split-sequence:split-sequence "" (cdr input) :test #'equal :remove-empty-subseqs t)))

(defun in-card? (num card)
  (some (lambda (x) (member num x)) card))

(defun bingo-card? (card nums)
  (some (lambda (x) (if (subsetp x nums) (list card nums) nil))
        (append card
                (loop for i in (first card)
                      for j in (second card)
                      for k in (third card)
                      for l in (fourth card)
                      for m in (fifth card)
                      collect (list i j k l m)))))

(defun bingo? (board)
  (some (lambda (x) (bingo-card? (first x) (second x)))
        board))

(defun play ()
  (let ((board (mapcar (lambda (x) (list x nil)) cards)))
    (loop for num in random-num
          do (setf board (loop for (card nums) in board
                               if (in-card? num card)
                                 do (push num nums)
                               collect (list card nums)))
          if (bingo? board)
            collect (list num (bingo? board))
            and do (setf board (loop for (card nums) in board
                                     if (not (bingo-card? card nums))
                                       collect (list card nums))))))

(defun unmarked-nums (card nums)
  (set-difference (alexandria:flatten card) nums))

(defun part1 ()
  (let ((result (first (play))))
    (* (car result) (reduce #'+ (unmarked-nums (first (second result)) (second (second result)))))))

(defun part2 ()
  (let ((result (car (last (play)))))
    (* (car result) (reduce #'+ (unmarked-nums (first (second result)) (second (second result)))))))
