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
        ((:mob :name "Spiderant")
         (:coordinate :x 6d0 :y 40d0)
         (:sprite :prefab :spiderant :layers-initially-toggled '(:body))
         (:character :target-x 6d0 :target-y 40d0 :speed 1d0)
         (:hp :current 50d0 :maximum 50d0))
        ((:mob :name "Spiderant")
         (:coordinate :x 18d0 :y 45d0)
         (:sprite :prefab :spiderant :layers-initially-toggled '(:body))
         (:character :target-x 18d0 :target-y 45d0 :speed 1d0)
         (:hp :current 50d0 :maximum 50d0))
        ((:coordinate :x 0d0 :y 0d0)
         (:map :prefab :map))))
     :display-width 800
     :display-height 600
     :display-font "alegreya.otf")))
