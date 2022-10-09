# [ -z "$TMUX" ] || tmux select-pane -t :.$(tmux list-panes | awk -F: 'END{print $1}')
# [ -z "$TMUX" ] || tmux select-pane -t 
# awk -F: 'END{print "a"
# awk -F: 
# read input to generate commands and run them though bash
awk '
# empty line is send as "Enter"
/^$/{
 print "tmux send-keys "t" C-M"
 next
}
# lines wich starts with "---" with nothing else is the correct way to send "Enter" without having a new line
/^---$/{
 print "tmux send-keys "t" C-M"
 next
}
# lines starting with "--- ##" are comments displayed in the message bar (have only one # if you do not want them displayed)
/^--- ##* /{
 print "tmux display-message "t" -- " q $0 q
}
# lines starting with ---WAIT--- wait while the cursor is at x=0
/^---WAIT---/{
 print "echo ======>/tmp/.tmux.cursor ; while tmux run-shell -b "q"echo xx#{cursor_x}xx>/tmp/.tmux.cursor"q" ; sleep 1 ; grep xx0xx /tmp/.tmux.cursor >/dev/null ; do echo -n . ; done"
}
# new version (before just for compatibility)
/^---/{
 sub(/^.*---/,"")
 print
 next
}
# lines not starting with "tmux" or with "---" will be send with send-keys
/^--! / || /^##! / {
 sub(/^[-#]*! /,"")
 print
 next
}
# When full paragraph, slow down only the lines
action=="Paragraph" && !/^---/{
 # the line will be send in quotes, so we have to replace quotes with: end quote, add double-quote within quote, start quote again
 gsub(q, q qq q qq q)
 # we add tmux send-keys in front
 $0="sleep 0.005 ; tmux send-keys "t" -- " q $0 q " C-M"
 # in tmux ; is special when at the end so I backslash it there
 sub(";"q" C-M","\\;"q" C-M" )
 # this tmux send-key goes to output to be run by shell
 print
 next
}
!/^---/{
 # the line will be send in quotes, so we have to replace quotes with: end quote, add double-quote within quote, start quote again
 gsub(q, q qq q qq q)
 # we add tmux send-keys in front
 $0="sleep 0.005 ; tmux send-keys "t" -- " q $0 q " C-M"
 # in tmux ; is special when at the end so I backslash it there
 sub(";"q" C-M","\\;"q" C-M" )
 # this tmux send-key goes to output to be run by shell
 print
 next
 next
 # this is old caracter per caracter code
split($0, chars, "")
for (i=1;i<=length($0);i++) { 
 if ( chars[i] == q   ) chars[i]=q qq q qq q
 if ( chars[i] == ";" ) chars[i]="\\;"
 print "tmux send-keys "t" -- " q chars[i] q
 #print "tmux send-keys "t" -- " q chars[i] q
 if ( chars[i] == " " ) print "sleep 0.0005"
 if ( chars[i] == "\\;" ) print "sleep 0.0009"
 }
 print "sleep 0.05 ; tmux send-keys "t" C-M"
 # the line will be send in quotes, so we have to replace quotes with: end quote, add double-quote within quote, start quote again
 next
}
' q="'" qq='"' t='$1' action="$1" > /tmp/runFromVim.log 

[ "$1" == "F12" ] && sed -e 's/sleep [0-9.]* ;//g' -i /tmp/runFromVim.log

# unmark all panes
tmux select-pane -M
# if called from tmux itself, go to the last pane selected to get the pane number, and back
[ -z "$TMUX" ] || { tmux last-pane || exit ; }
t=$(tmux list-panes | awk -F: '/[(]active[)]/{print $1}')
tmux select-pane -m
[ -z "$TMUX" ] || { tmux last-pane || exit ; }

bash /tmp/runFromVim.log "-t:.$t"

# if called from tmux itself, go back last pane of the window
# [ -z "$TMUX" ] || tmux select-pane -t :.$(tmux list-panes | awk -F: 'END{print $1}')


