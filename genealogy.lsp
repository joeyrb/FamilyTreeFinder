#| ###############################################
# Main/IO Functions                              #
##################################################
		***genealogy.lsp***

Description:
Write a Lisp program that reads in a file of family relationships, builds a database, and then allows
queries to that database. Queries include: parents, mothers, fathers, children, sons, daughters, siblings,
sisters, brothers, grandparents, grandfathers, grandmothers, grandchildren, grandsons,
granddaughters, uncles, aunts, nieces, nephews, cousins, male-cousins, female-cousins, ancestors, maleancestors,
female-ancestors, descendants, male-descendants, and female-descendants.

Usage : $>> clisp –repl genealogy.lsp family.dat
############################################### |#
#| load all function files |#
(load "q_funcs.lsp")


; Global database 
(defvar *database* (list nil))


; Given struct to store person in database
(defstruct person 
    name
    gender
    parents
    children
)


(defun getFamTree (inputFile)
    "Reads input file from command line and generates list for family tree"
	; Check for file
	(setf fin (open inputFile :if-does-not-exist nil))   ; open file, returning NIL on error
    (when (null fin) (return-from getFamTree (format nil "Error: cannot open file ~a~%" inputFile)))

    ; read file and dump contents
    (format t "Contents of ~a:~%" inputFile)
    (do ((data (read fin nil) (read fin nil)))
        ; read entire file, returning NIL at EOF
        ((null data) (close fin))                       
        ; exit when file is read
        (format t "~a~%" data)                          
        ; print what we read
        (setf *database* 
            (push 
                (make-person 
                    :name (nth 0 data) 
                    :gender (nth 1 data) 
                    :parents (nth 2 data) 
                    :children (nth 3 data)
                )
                *database*
            )
        )
        ; populate the database
    )
)

; call function w/ command line args
(getFamTree (car *args*))