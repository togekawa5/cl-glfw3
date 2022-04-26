;;;; icons.lisp
;;;; This example shows changed icon.
(in-package #:cl-glfw3-examples)

(export '(icons-example))

(defparameter *cl* #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                     0 0 0 1 1 0 0 0 0 0 2 0 0 0 0 0
                     0 0 1 0 0 1 0 0 0 0 2 0 0 0 0 0
                     0 1 0 0 0 0 0 0 0 0 2 0 0 0 0 0
                     0 1 0 0 0 0 0 0 0 0 2 0 0 0 0 0
                     0 0 1 0 0 1 0 0 0 0 2 0 0 0 0 0
                     0 0 0 1 1 0 0 0 0 0 2 2 2 2 0 0
                     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                     0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
                     0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
                     0 0 0 0 0 0 0 0 0 1 0 2 0 3 0 0
                     0 0 0 0 0 0 0 0 0 0 0 2 0 3 0 0
                     0 0 0 0 0 0 0 0 0 0 2 0 0 0 3 0
                     0 0 0 0 0 0 0 0 0 0 2 0 0 0 3 0
                     0 0 0 0 0 0 0 0 0 0 0 2 0 3 0 0
                     0 0 0 0 0 0 0 0 0 0 0 2 0 3 0 0))

(defparameter *cl2* #2a((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
			(0 0 0 1 1 0 0 0 0 0 2 0 0 0 0 0)
			(0 0 1 0 0 1 0 0 0 0 2 0 0 0 0 0)
			(0 1 0 0 0 0 0 0 0 0 2 0 0 0 0 0)
			(0 1 0 0 0 0 0 0 0 0 2 0 0 0 0 0)
			(0 0 1 0 0 1 0 0 0 0 2 0 0 0 0 0)
			(0 0 0 1 1 0 0 0 0 0 2 2 2 2 0 0)
			(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
			(0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0)
			(0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0)
			(0 0 0 0 0 0 0 0 0 1 0 2 0 3 0 0)
			(0 0 0 0 0 0 0 0 0 0 0 2 0 3 0 0)
			(0 0 0 0 0 0 0 0 0 0 2 0 0 0 3 0)
			(0 0 0 0 0 0 0 0 0 0 2 0 0 0 3 0)
			(0 0 0 0 0 0 0 0 0 0 0 2 0 3 0 0)
			(0 0 0 0 0 0 0 0 0 0 0 2 0 3 0 0)))

(defun dot-image (width height array)
  (let ((image (make-image width height)))
    (loop for j from 0 below height do
          (loop for i from 0 below width do
                (multiple-value-bind (red green blue alpha)
                    (ecase (aref array (+ i (* j width)))
                      (0 (values 0 0 0 0));transparent
                      (1 (values #xff 0 0 #xff));red
                      (2 (values 0 #xff 0 #xff));green
                      (3 (values 0 0 #xff #xff));blue
                      (4 (values #xff #xff 0 #xff));yellow
                      (5 (values #xff 0 #xff #xff));magenta
                      (6 (values 0 #xff #xff #xff));cyan
                      (7 (values #xff #xff #xff #xff));white
                      (8 (values 0 0 0 #xff)));black
                  (setf (aref (image-pixels image) (+ 0 (* 4 (+ i (* j width))))) red)
                  (setf (aref (image-pixels image) (+ 1 (* 4 (+ i (* j width))))) green)
                  (setf (aref (image-pixels image) (+ 2 (* 4 (+ i (* j width))))) blue)
                  (setf (aref (image-pixels image) (+ 3 (* 4 (+ i (* j width))))) alpha))))
    image))

(defun dot-image+ (dot-array)
  (let* ((width (array-dimension dot-array 0))
	 (height (array-dimension dot-array 1))
	 (image (make-array `(,height ,width 4))))
    (loop for j from 0 below height do
          (loop for i from 0 below width do
		(destructuring-bind (r g b a)
		  (ecase (aref dot-array i j)
		    (0 '(0 0 0 0));transparent
		    (1 '(#xff 0 0 #xff));red
		    (2 '(0 #xff 0 #xff));green
		    (3 '(0 0 #xff #xff));blue
		    (4 '(#xff #xff 0 #xff));yellow
		    (5 '(#xff 0 #xff #xff));magenta
		    (6 '(0 #xff #xff #xff));cyan
		    (7 '(#xff #xff #xff #xff));white
		    (8 '(0 0 0 #xff)));black
		  (setf (aref image i j 0) r)
		  (setf (aref image i j 1) g)
		  (setf (aref image i j 2) b)
		  (setf (aref image i j 3) a))))
    image))

#|
(defparameter *cl-image* (dot-image 16 16 *cl*))
(defparameter *red-image* (dot-image 48 48 (make-array (* 48 48) :initial-element 1)))
(defparameter *green-image* (dot-image 48 48 (make-array (* 48 48) :initial-element 2)))
(defparameter *blue-image* (dot-image 48 48 (make-array (* 48 48) :initial-element 3)))
(defparameter *yellow-image* (dot-image 48 48 (make-array (* 48 48) :initial-element 4)))
(defparameter *magenta-image* (dot-image 48 48 (make-array (* 48 48) :initial-element 5)))
(defparameter *cyan-image* (dot-image 48 48 (make-array (* 48 48) :initial-element 6)))
(defparameter *white-image* (dot-image 48 48 (make-array (* 48 48) :initial-element 7)))
(defparameter *black-image* (dot-image 48 48 (make-array (* 48 48) :initial-element 8)))
(defparameter *color-check* (dot-image 48 48 (make-array (* 48 48)
                                                         :initial-contents
                                                         (let ((acc nil))
                                                           (loop for i from 1 below 9 do
                                                                 (dotimes (j (* 6 48))
                                                                   (push i acc)))
                                                           (reverse acc)))))
|#
(defparameter *cl-image* (dot-image+ *cl2*))
(defparameter *red-image* (dot-image+ (make-array '(48 48) :initial-element 1)))
(defparameter *green-image* (dot-image+ (make-array '(48 48) :initial-element 2)))
(defparameter *blue-image* (dot-image+ (make-array '(48 48) :initial-element 3)))
(defparameter *yellow-image* (dot-image+ (make-array '(48 48) :initial-element 4)))
(defparameter *magenta-image* (dot-image+ (make-array '(48 48) :initial-element 5)))
(defparameter *cyan-image* (dot-image+ (make-array '(48 48) :initial-element 6)))
(defparameter *white-image* (dot-image+ (make-array '(48 48) :initial-element 7)))
(defparameter *black-image* (dot-image+ (make-array '(48 48) :initial-element 8)))
(defparameter *color-check* (dot-image+ (let ((img (make-array '(45 45))))
					  (loop for i from 1 below 45 do
						(loop for j from 0 below 45 do
						      (setf (aref img i j)
							    (floor (/ i 5)))))
					  img)))


(defun icons-example ()
  ;; Graphics calls on OS X must occur in the main thread
  (with-body-in-main-thread ()
    (with-init-window (:title "Icon test" :width 600 :height 400)
      (set-window-icon *cl-image*)
      (let ((cursors (make-array 10 :initial-contents (list (create-cursor *color-check* 0 0)
                                                            (create-cursor *yellow-image* 48 0)
                                                            (create-cursor *red-image* 0 48)
                                                            (create-cursor *blue-image* 24 24)
                                                            (create-standard-cursor :arrow)
                                                            (create-standard-cursor :ibeam)
                                                            (create-standard-cursor :crosshair)
                                                            (create-standard-cursor :hand)
                                                            (create-standard-cursor :hresize)
                                                            (create-standard-cursor :vresize))))
            (cursor-num 0))
        (def-mouse-button-callback mouse-cursor-change-callback (window button action mod-keys)
          (declare (ignore window mod-keys))
          (if (eq action :press)
              (setf cursor-num (mod (+ cursor-num
                                       (cond ((eq button :left) 1)
                                             ((eq button :right) -1)
                                             (t 0)))
                                    10))
              (set-cursor (aref cursors cursor-num))))
        (set-mouse-button-callback 'mouse-cursor-change-callback)
        (set-cursor (aref cursors cursor-num))
        (loop until (window-should-close-p)
              do (poll-events))
        (loop for i from 0 below 10 do
              (destroy-cursor (aref cursors i)))))))
