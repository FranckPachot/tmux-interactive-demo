# tmux-interactive-demo

Here are the scripts I use to run my live demos. The idea was described in: https://www.dbi-services.com/blog/using-tmux-for-semi-interactive-demos/
Those scripts work, but are ugly. I'll clean them one day.
The basic functionality is:
- PageDown sends the current line to tmux, with some special characters to ignore, or run a command
- `§` and `°` rin a paragraph. The latter moves the cursor to the next paragraph
- when run from tmux itself, the script is expected to be opened in the last pane and sends keys to the previously selected one
