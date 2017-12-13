#|################################################
# Recursive Query Functions                      #
##################################################
        ***recursive_funcs.lsp***

Recursive functions that find all of the immediate 
relateives of a person.
############################################### |#

(defun ancestors (personname)
    "Returns all recursive parents of person.
    Calls checkdescendants of each parent of person,
    which returns the ancestors of that parent plus
    the parent in a list."
    (cond
        ((remove nil (parents personname)) 
            (apply #'append
                (map 'list #'checkancestors 
                    (remove nil (parents personname)))
        ))
        (t (list personname))
    )
)


(defun descendants (personname)
    "Returns all recursive children of person.
    Calls checkdescendants of each child of person,
    which returns the descendants of that child plus
    the child in a list."
    (cond
        ((remove nil (children personname)) 
            (apply #'append
                (map 'list #'checkdescendants 
                    (remove nil (children personname)))
        ))
        (t (list personname))
    )
)