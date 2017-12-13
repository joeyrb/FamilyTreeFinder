#|################################################
# Dependent Query Functions                      	 #
##################################################
        ***dependent_funcs.lsp***

These are functions that are the first to depend 
on the base functions before applying gender filters.
############################################### |#

(defun grandparents (personname)
	"Returns the parents of parents of person"
    (apply #'append 
        (removecopies 
        	(map 'list #'parents (remove nil (parents personname))) 
        	(remove nil (parents personname)))
    )
)


(defun grandchildren (personname)
	"Returns the children of children of person"
    (apply #'append 
        (removecopies 
        	(map 'list #'children (remove nil (children personname))) 
        	(remove nil (children personname)))
    )
)


(defun cousins (personname)
	"Returns children of a person's parents siblings."
	(remove personname
		(remove-duplicates
		    (apply #'append
		    	(removecopies 
		    		(map 'list #'children (remove nil (cousins_helper personname)))	
		    		(siblings personname)
				)
			)
		)
	)
)