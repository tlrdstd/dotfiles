export COLOR_NC='\e[0m' # No color
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_BROWN='\e[0;33m'
export COLOR_CYAN='\e[0;36m'
export COLOR_DARK_GRAY='\e[1;30m'
export COLOR_GRAY='\e[1;30m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_LIGHT_GRAY='\e[0;37m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_LIGHT_RED='\e[1;31m' # Solarized orange
export COLOR_PURPLE='\e[0;35m'
export COLOR_RED='\e[0;31m'
export COLOR_WHITE='\e[1;37m'
export COLOR_YELLOW='\e[1;33m'

#export COLOR_BOLD='\[\e]1m\]'

# XXX - these escape sequences only really work in Bash.
# XXX - if these are needed in zsh, do things somewhat differently.
# escaped color sequences, for proper character counts in shell prompts
for color in $(set | egrep -a '^COLOR_\w*' | cut -f1 -d"="); do
  eval "export ESC_${color}=\${color}"
done
