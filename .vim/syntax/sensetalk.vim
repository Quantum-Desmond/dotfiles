syn region senseCommentString	contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end=+\*)+me=s-1
syn region senseComment2String	contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end="$"

syn region senseBlockComment start="(\*" end="\*)" contains=senseCommentString extend
syn region senseCommentL start="//" skip="\\$" end="$" keepend contains=senseComment2String
syn region senseCommentL start="--" skip="\\$" end="$" keepend contains=senseComment2String

syn match	senseCommentError	display "\*)"
syn match	senseCommentStartError display "(\*"me=e-1 contained
syn match	senseWrongComTail	display "\*)"

syn region senseString start=+"+ end=+"+

" This applies to everything that follows:
syn case ignore

syn keyword senseStatement run
syn keyword senseStatement if then end repeat by
syn keyword senseStatement put insert into before after set to

syn keyword senseStatement Click TypeText

syn keyword senseStatement connect log
syn keyword senseStatement wait waitfor

" This is the wrong way to do it: should take into account diff versions...
hi def link senseBlockComment       senseComment
hi def link senseCommentL           senseComment
hi def link senseComment            Comment
hi def link senseString             String
hi def link senseStatement          Statement
