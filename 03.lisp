(defparameter input (mapcar (lambda (x) (map 'list #'digit-char-p x)) (uiop:read-file-lines "03.txt")))

;;; PART 1

(defparameter bool-repr
  (mapcar (lambda (x)
            (> x (/ (length input) 2)))
          (reduce (lambda (acc x)
                    (mapcar #'+ acc x))
                  input)))

(defparameter gamma-rate (parse-integer (format nil "~{~A~}" (mapcar (lambda (x) (if x 1 0)) bool-repr)) :radix 2))
(defparameter epsilon-rate (parse-integer (format nil "~{~A~}" (mapcar (lambda (x) (if x 0 1)) bool-repr)) :radix 2))

(format t "Part 1: ~a~&" (* gamma-rate epsilon-rate))

;;; PART 2

(defun bit-crit-oxygen (input n-bit)
  (let ((threshold (/ (length input) 2)))
    (if (<= threshold (reduce #'+
                              (mapcar (lambda (x)
                                        (nth n-bit x))
                                      input)))
        1
        0)))

(defun bit-crit-co2 (input n)
  (let ((threshold (/ (length input) 2)))
    (if (> threshold (reduce #'+
                             (mapcar (lambda (x)
                                       (nth n x))
                                     input)))
        1
        0)))

(defun filter-bit-crit (input bit-crit n)
  (remove-if-not (lambda (x) (= bit-crit (nth n x))) input))

(defparameter oxygen input)
(defparameter co2 input)

(defparameter oxygen-rate (loop for i from 0 below (length (first input))
                                while (> (length oxygen) 1)
                                do
                                   (let ((crit-oxygen (bit-crit-oxygen oxygen i)))
                                     (setf oxygen (filter-bit-crit oxygen crit-oxygen i)))
                                finally (return (parse-integer (format nil "~{~A~}" (car oxygen)) :radix 2))))

(defparameter co2-rate (loop for i from 0 below (length (first input))
                             while (> (length co2) 1)
                             do
                                (let ((crit-co2 (bit-crit-co2 co2 i)))
                                  (setf co2 (filter-bit-crit co2 crit-co2 i)))
                             finally (return (parse-integer (format nil "~{~A~}" (car co2)) :radix 2))))

(format t "Part 2: ~a~&" (* oxygen-rate co2-rate))
