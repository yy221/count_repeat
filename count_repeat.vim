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
    count_type = vim.eval("a:arg1")
    print type(count_type);

    # vim.current.buffer is the current buffer. It's list-like object.
    # each line is an item in the list. We can loop through them delete
    # them, alter them etc.

    buf = vim.current.buffer;

    if int(count_type) == 2: # simple sum
        res = 0
        total = 0

        for line in buf:
            total += 1
            res += float(line)

        if total > 0:
            buf.append ( 'avg=%.3f, total=%d, sum=%.3f' %(res/total, total, res) )
    elif int(count_type) == 1: # sort counter
        res = {}

        for line in buf:
            res[line] = res.get (line, 0) + 1
        res_sorted = sorted ( res.iteritems(), key=lambda x:x[1], reverse=True )

        buf.append ( '--------result--------' )
        for (k,v) in res_sorted:
            buf.append ( '%8d,%s' %(v,k) )
    else:  # simple merge adjacent line
        res = []
        count = 1
        res.append('--------result--------')

        for line in buf:
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
