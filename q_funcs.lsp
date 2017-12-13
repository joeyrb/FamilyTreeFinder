#|################################################
# Base Query Functions                      	 #
##################################################
        ***q_funcs.lsp***

The base functions of all the query commands. All
database queries will call a combination of these 
queries.
############################################### |#
; Load related Functions 					    
(load "helper_funcs.lsp")
(load "filter_funcs.lsp")
(load "dependent_funcs.lsp")
(load "recursive_funcs.lsp")
(load "family_funcs.lsp")
#| ############################################ |#


(defun children (personname)
	"Returns children (if existing, else nil) of the person with the given name."
    (cond
        ((query personname) (person-children (query personname)))
        (t nil)
    )
)


(defun parents (personname)
	"Returns parents (if existing, else nil) of the person with the given name."
    (cond
        ((query personname) (person-parents (query personname)))
        (t nil)
    )
)


(defun siblings (personname)
	"Returns siblings of person's parents"
    (remove-duplicates 
        (removecopies 
            (apply #'append (map 'list #'children (remove nil (parents personname)))) 
            (list personname)
        )
    )

)