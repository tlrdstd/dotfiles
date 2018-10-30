export COLOR_BOLD='\[\e]1m\]'

# XXX - these escape sequences only really work in Bash.
# XXX - if these are needed in zsh, do things somewhat differently.

# escaped color sequences, for proper character counts in shell prompts
for color in $(set | egrep -a '^COLOR_\w*' | cut -f1 -d"="); do
  eval "export ESC_${color}=\${color}"
done
