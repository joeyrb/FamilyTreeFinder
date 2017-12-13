#| ###############################################
# Helper Functions                               #
##################################################
        ***helper_funcs.lsp***

Functions used to manipulate lists of peolple and
make other functions easier to use. Also reduces 
lots of repeated code.
############################################### |#

(defun query (personname)
    "Backend function that other functions call to get the tuple of the person
    with the given name, if it exists in the database."
    (cond
        ((checkmember personname *database*) 
            (find-if 
                (lambda (x) (string= (person-name x) personname)) *database*))
        (t nil)
    )
)


(defun checkmember (personname lst)
    "Recursively checks to see if the given name is in the given list. Returns T if the name is found, NIL if not."
    (cond 
        ((car lst)
            (or (string= (person-name (car lst)) personname) 
                (checkmember personname (cdr lst))))
        (t nil)
    )
)


(defun removecopies (target source)
    "Iterates through items in target and returns a list of the items from target that are not in source."
    (loop for item in target
        unless (member item source)
        collect item
    )
)


(defun checkancestors (personname)
    "Returns personname's ancestors and personname"
    (cond
        ((remove nil (parents personname)) 
            (append 
                (apply #'append
                    (map 'list #'checkancestors (remove nil (parents personname))))
                (list personname)
            )
        )
        (t (list personname))
    )
)


(defun checkdescendants (personname)
    "Returns personname's decendents and personname"
    (cond
        ((remove nil (children personname)) 
            (append 
                (apply #'append
                    (map 'list #'checkdescendants (remove nil (children personname)))
                )
                (list personname)
            )
        )
        (t (list personname))
    )
)

(defun cousins_helper (personname)
    "Returns siblings of parents for cousins."
    (remove personname
        (remove-duplicates
            (apply #'append
                (removecopies 
                    (map 'list #'siblings (remove nil (parents personname)))    ; WORKING v1.0
                    (remove nil (children personname))
                )
            )
        )
    )
)


(defun getauntsuncles (personname)
    "Gets the parents of person's cousins by getting parents of children of siblings of parents of person.
    Also gets the siblings of parents and adds those on (removing duplicates) just in case any didn't have children."
    (remove-duplicates 
        (append
            (apply #'append 
                (map 'list #'parents 
                    (apply #'append 
                        (map 'list #'children 
                            (apply #'append 
                                (map 'list #'siblings 
                                    (parents personname)
                                )
                            )
                        )
                    )
                )
            )
            (apply #'append
                (map 'list #'siblings 
                    (parents personname)
                )
            )
        )
    )
)