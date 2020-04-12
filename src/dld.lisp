(in-package :dld)


(defun main ()
  (d2c:with-condition-reporter
    (d2c:start-engine
     "Darkness Looming: The Dawn"
     (mapcar
      #'d2c:make-entity-initializer
      '(((:camera)
         (:coordinate :x 12d0 :y 38d0))
        ((:player)
         (:coordinate :x 12d0 :y 38d0)
         (:sprite :prefab :heroine :layers-initially-toggled '(:head :clothes))
         (:character :target-x 12d0 :target-y 38d0)
         (:hp :current 100d0 :maximum 100d0)
         (:mana :current 100d0 :maximum 100d0))
        ((:coordinate :x 0d0 :y 0d0)
         (:map :prefab :map)))))))
