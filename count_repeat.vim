" count repeat line tool
"=============================================================================
" Copyright: Copyright (C) 2013 chliu
" License:	The MIT License

if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif


function! CountRepeatLine (arg1)

python << EOF
import vim

try:
    need_sort = vim.eval("a:arg1")
    print type(need_sort);

    # vim.current.buffer is the current buffer. It's list-like object.
    # each line is an item in the list. We can loop through them delete
    # them, alter them etc.

    buf = vim.current.buffer;

    if int(need_sort) == 1:
        res = {}

        for line in buf:
            res[line] = res.get (line, 0) + 1
        res_sorted = sorted ( res.iteritems(), key=lambda x:x[1], reverse=True )

        buf.append ( '--------result--------' )
        for (k,v) in res_sorted:
            buf.append ( '%8d,%s' %(v,k) )
    else:
        res = []
        count = 1
        res.append('--------result--------')
        for line in buf:
            # simple merge adjacent line
            if line != res[count-1]:
                count += 1
                res.append(line)

        for i in res:
            buf.append ( '%s' %(i) )

except Exception, e:
    print e

EOF

endfunction

command! -nargs=1 MyCountRepeatLine :call CountRepeatLine(<f-args>)
