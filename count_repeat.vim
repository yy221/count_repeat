" count repeat line tool
"=============================================================================
" Copyright: Copyright (C) 2013 chliu
" License:	The MIT License 

if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif


function! CountRepeatLine () 

python << EOF
import vim 

try:
    res = {}

    # vim.current.buffer is the current buffer. It's list-like object.
    # each line is an item in the list. We can loop through them delete
    # them, alter them etc.

    buf = vim.current.buffer;

    for line in buf:
        res[line] = res.get (line, 0) + 1

    buf.append ( '--------result--------' )

    #print res

    res_sorted = sorted ( res.iteritems(), key=lambda x:x[1], reverse=True )

    #print res_sorted

    for (k,v) in res_sorted:
        buf.append ( '%8d,%s' %(v,k) ) 

except Exception, e:
    print e

EOF

endfunction

command! -nargs=0 MyCountRepeatLine :call CountRepeatLine()
