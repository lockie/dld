(asdf:defsystem :dld
  :version (:read-file-line "version.txt")
  :description "Darkness Looming: The Dawn"
  :author "Andrew Kravchuk <awkravchuk@gmail.com>"
  :license "GPL v3"
  :depends-on ((:version :d2clone-kit "0.1.1"))
  :pathname "src"
  :serial t
  :components ((:file "package")
               (:file "dld"))
  :around-compile (lambda (next)
                    (when (find :release *features*)
                      (proclaim '(optimize
                                  (speed 3)
                                  (debug 0)
                                  (compilation-speed 0)
                                  (safety 1))))
                    (funcall next))
  :defsystem-depends-on (:deploy)
  :build-operation "deploy:deploy-op"
  :build-pathname "dld"
  :entry-point "dld:main")
