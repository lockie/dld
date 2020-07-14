(proclaim '(optimize (speed 3) (safety 0) (debug 0) (compilation-speed 0) (space 0)))
(ql:quickload '(:d2clone-kit :deploy))
(push (truename ".") asdf:*central-registry*)
(asdf:make :dld)
