(ql:quickload '(:d2clone-kit :deploy))

(push (truename ".") asdf:*central-registry*)
(push :release *features*)
(uiop:delete-directory-tree #P"bin/" :validate t :if-does-not-exist :ignore)
(let ((pid (sb-posix:fork)))
  (cond
    ((zerop pid)
     (asdf:make :dld))
    ((plusp pid)
     (sb-posix:waitpid pid 0)
     (asdf:run-shell-command "tar -czf darkness-looming-the-dawn.tar.gz assets bin")
     (exit))
    (t
     (error "fork failed"))))
