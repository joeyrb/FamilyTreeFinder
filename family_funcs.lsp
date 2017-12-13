#|###############################################
# Family Filter functions                       #
#################################################
        ***family_funcs.lsp***

All of these functions use a combination of the
base query functions (parents, children, siblings)
in combination with gender filters to return lists
of different family relationships.
############################################### |#
(defun mothers (personname)
    "Calls female filter on parents"
    (femalefilter (parents personname))
)


(defun fathers (personname)
    "Calls male filter on parents"
    (malefilter (parents personname))
)


(defun sons (personname)
    "Calls male filter on children"
    (malefilter (children personname))
)


(defun daughters (personname)
    "Calls female filter on children"
    (femalefilter (children personname))
)


(defun sisters (personname)
    "Calls female filter on siblings"
    (femalefilter (siblings personname))
)


(defun brothers (personname)
    "Calls male filter on siblings"
    (malefilter (siblings personname))
)


(defun grandfathers (personname)
    "Calls male filter on grandparents"
    (malefilter (grandparents personname))
)


(defun grandmothers (personname)
    "Calls female filter on grandparents"
    (femalefilter (grandparents personname))
)


(defun grandsons (personname)
    "Calls male filter on grandchildren"
    (malefilter (grandchildren personname))
)


(defun granddaughters (personname)
    "Calls female filter on grandchildren"
    (femalefilter (grandchildren personname))
)


(defun uncles (personname)
    "Gets the males of parent's siblings and their spouses"
    (malefilter (getauntsuncles personname))
)


(defun aunts (personname)
    "Gets the females of parent's siblings and their spouses"
    (femalefilter (getauntsuncles personname))
)


(defun nieces (personname)
    "Gets the female children of person's siblings"
    (femalefilter (apply #'append (map 'list #'children (siblings personname))))
)


(defun nephews (personname)
    "Gets the male children of person's siblings"
    (malefilter (apply #'append (map 'list #'children (siblings personname))))
)


(defun male-cousins (personname)
    "Calls male filter on cousins"
    (malefilter (cousins personname))
)


(defun female-cousins (personname)
    "Calls female filter on cousins"
    (femalefilter (cousins personname))
)


(defun male-ancestors (personname)
    "Calls male filter on ancestors"
    (malefilter (ancestors personname))
)


(defun female-ancestors (personname)
    "Calls female filter on ancestors"
    (femalefilter (ancestors personname))
)


(defun male-descendants (personname)
    "Calls male filter on descendants"
    (malefilter (descendants personname))
)


(defun female-descendants (personname)
    "Calls female filter on descendants"
    (femalefilter (descendants personname))
)