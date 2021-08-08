(in-package :dld)

(alexandria:define-constant +version-string+
    (format nil "v ~a" (slot-value (asdf:find-system :dld) 'asdf:version))
  :test #'string=)

(defun main ()
  (d2c:start-engine
   "Darkness Looming: The Dawn"
   '(((:camera)
      (:coordinate :x 22d0 :y 2d0))
     ((:coordinate :x 0d0 :y 0d0)
      (:map :prefab :map))
     ((:player)
      (:coordinate :x 22d0 :y 2d0)
      (:sprite :prefab :heroine :layers-initially-toggled (:head :clothes))
      (:character)
      (:hp :current 100d0 :maximum 100d0)
      (:mana :current 100d0 :maximum 100d0)
      (:combat :min-damage 1d0 :max-damage 2d0))
     ((:item :type :great-sword)
      (:coordinate :x 95.5d0 :y -72.5d0))
     ;; TODO : have the ability to embed this in tmx file
     ((:mob :name "Spiderant")
      (:coordinate :x 30.5d0 :y 12.5d0)
      (:sprite :prefab :spiderant :layers-initially-toggled (:body))
      (:character :speed 3d0)
      (:hp :current 15d0 :maximum 15d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Spiderant")
      (:coordinate :x 41.5d0 :y 7.5d0)
      (:sprite :prefab :spiderant :layers-initially-toggled (:body))
      (:character ::speed 3d0)
      (:hp :current 15d0 :maximum 15d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Spiderant")
      (:coordinate :x 42d0 :y 4d0)
      (:sprite :prefab :spiderant :layers-initially-toggled (:body))
      (:character :speed 3d0)
      (:hp :current 15d0 :maximum 15d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Spiderant")
      (:coordinate :x 77d0 :y 19d0)
      (:sprite :prefab :spiderant :layers-initially-toggled (:body))
      (:character :speed 3d0)
      (:hp :current 15d0 :maximum 15d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Spiderant")
      (:coordinate :x 67.5d0 :y -0.5d0)
      (:sprite :prefab :spiderant :layers-initially-toggled (:body))
      (:character :speed 3d0)
      (:hp :current 15d0 :maximum 15d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Spiderant")
      (:coordinate :x 71.5d0 :y -0.5d0)
      (:sprite :prefab :spiderant :layers-initially-toggled (:body))
      (:character :speed 3d0)
      (:hp :current 15d0 :maximum 15d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Spiderant")
      (:coordinate :x 77d0 :y -1d0)
      (:sprite :prefab :spiderant :layers-initially-toggled (:body))
      (:character :speed 3d0)
      (:hp :current 15d0 :maximum 15d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Spiderant")
      (:coordinate :x 59.5d0 :y 1.5d0)
      (:sprite :prefab :spiderant :layers-initially-toggled (:body))
      (:character :speed 3d0)
      (:hp :current 15d0 :maximum 15d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Zombie" :vision-range 5d0)
      (:coordinate :x 73d0 :y 28d0)
      (:sprite :prefab :zombie :layers-initially-toggled (:body))
      (:character :speed 0.5d0)
      (:hp :current 25d0 :maximum 25d0)
      (:combat :min-damage 2d0 :max-damage 12d0))
     ((:mob :name "Zombie" :vision-range 5d0)
      (:coordinate :x 99d0 :y -11d0)
      (:sprite :prefab :zombie :layers-initially-toggled (:body))
      (:character :speed 0.5d0)
      (:hp :current 25d0 :maximum 25d0)
      (:combat :min-damage 2d0 :max-damage 12d0))
     ((:mob :name "Zombie" :vision-range 5d0)
      (:coordinate :x 98d0 :y 8d0)
      (:sprite :prefab :zombie :layers-initially-toggled (:body))
      (:character :speed 0.5d0)
      (:hp :current 25d0 :maximum 25d0)
      (:combat :min-damage 2d0 :max-damage 12d0))
     ((:mob :name "Zombie" :vision-range 5d0)
      (:coordinate :x 93d0 :y -27d0)
      (:sprite :prefab :zombie :layers-initially-toggled (:body))
      (:character :speed 0.5d0)
      (:hp :current 25d0 :maximum 25d0)
      (:combat :min-damage 2d0 :max-damage 12d0))
     ((:mob :name "Zombie" :vision-range 5d0)
      (:coordinate :x 102d0 :y -36d0)
      (:sprite :prefab :zombie :layers-initially-toggled (:body))
      (:character :speed 0.5d0)
      (:hp :current 25d0 :maximum 25d0)
      (:combat :min-damage 2d0 :max-damage 12d0))
     ((:mob :name "Zombie" :vision-range 5d0)
      (:coordinate :x 87d0 :y 13d0)
      (:sprite :prefab :zombie :layers-initially-toggled (:body))
      (:character :speed 0.5d0)
      (:hp :current 25d0 :maximum 25d0)
      (:combat :min-damage 2d0 :max-damage 12d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 82d0 :y -12d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 107.5d0 :y 7.5d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 95.5d0 :y -54.5d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 102d0 :y -54d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 92d0 :y -68d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 107d0 :y -67d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 98d0 :y -68d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 99d0 :y -61d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 87.5d0 :y -62.5d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 85d0 :y -65d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 94d0 :y -72d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 109d0 :y -71d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton" :vision-range 7d0)
      (:coordinate :x 102d0 :y -80d0)
      (:sprite :prefab :skeleton :layers-initially-toggled (:body))
      (:character :speed 1d0)
      (:hp :current 20d0 :maximum 20d0)
      (:combat :min-damage 1d0 :max-damage 10d0))
     ((:mob :name "Skeleton Knight" :vision-range 8d0)
      (:coordinate :x 105d0 :y -75d0)
      (:sprite :prefab :skeleton-knight :layers-initially-toggled (:body))
      (:character :speed 0.7d0)
      (:hp :current 220d0 :maximum 220d0)
      (:combat :min-damage 4d0 :max-damage 18d0)))
   nil
   :display-width 800
   :display-height 600
   :display-font "alegreya-sc.ttf"))
