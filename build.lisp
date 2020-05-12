(push :release *features*)
(ql:quickload '(:d2clone-kit :deploy))
(push (truename ".") asdf:*central-registry*)
(asdf:make :dld)
