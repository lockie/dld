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
  :defsystem-depends-on (:deploy)
  :build-operation "deploy:deploy-op"
  :build-pathname "dld"
  :entry-point "dld:main")

#+linux (deploy:define-hook (:build sort-libs -1) ()
          ;; HACK for liballegro-nuklear to load
          (setf deploy::*foreign-libraries-to-reload*
                (nreverse deploy::*foreign-libraries-to-reload*)))
