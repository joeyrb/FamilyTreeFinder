#|###############################################
# Gender Filter functions 								#
#################################################
        ***filter_funcs.lsp***

Functions to separate people from a person list
based on their gender. Returns a list of people
with matching genders.
############################################### |#

; Male filter
(defun malefilter (personlist)
	"Returns a list of names of all males in a given list"
    (map 'list #'person-name ; maps tuples back to list of names
    	(remove nil 
    		(remove-if (lambda (x) (string= (person-gender x) 'female)) 
    			(fixfilterlist personlist) ; Filter requires gender and therefore needs the whole tuple
            )
        )
    )
)


; Female filter
(defun femalefilter (personlist)
	"Returns a list of names of all females in a given list"
    (map 'list #'person-name ; maps tuples back to list of names
    	(remove nil 
    		(remove-if (lambda (x) (string= (person-gender x) 'male)) 
    			(fixfilterlist personlist) ; Filter requires gender and therefore needs the whole tuple
            )
        )
    )
)


(defun fixfilterlist (personlist)
	"Maps list of names into list of respective tuples"
    (remove nil (map 'list #'query (remove nil personlist)))
)