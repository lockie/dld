(ql:quickload '(:d2clone-kit :deploy))
(push (truename ".") asdf:*central-registry*)
(push :release *features*)
(asdf:make :dld)
