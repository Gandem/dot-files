#!/usr/bin/env bash

# list your emails here, separated with a space
MAILS=""

bold=$(tput bold)
reset=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
clear=$(tput el)


function menu_items {
# input: list of menu items
# output: item selected
# exit codes: 0 - normal, 1 - abort, 2 - no menu items, 3 - too many items
# to select item, press enter; to abort press q

[[ $# -lt 1 ]] && exit 2 # no menu items, at least 1 required

if [[ $# -gt $(( `tput lines` - 1 )) ]]; then
    echo ${bold}"Hey ! You have"${red}" so many "${reset}${bold}"options, it doesn't fit in your shell..."${reset};
    exit 3 # more items than rows;
fi

# keys
au="$(echo -e $'\033'[A)" # arrow up
ad="$(echo -e $'\033'[B)" # arrow down
ec="$(echo -e '\e')"   # escape
nl="$(echo -e '\n')"   # newline

tn="$#" # total number of items

{ # capture stdout to stderr

trap "tput cnorm -- normal; exit" SIGINT
tput civis # hide cursor

cp=1 # current position

end=false

while ! ${end}
do

   for i in `seq 1 ${tn}`
   do

      echo -n "$reset"
      [[ ${cp} == ${i} ]] && echo -ne "\xE2\x86\x92$bold$green"

      echo "$clear" $(eval "echo \$${i}")

   done

   read -sn1 esc
   read -sn1 -t 0.101 bra # "-t 0.001" is for robust-ness so pressing just any key wont put it into the wrong "read"
   read -sn1 -t 0.101 typ

   case "$esc$bra$typ" in

      "$au")
         cp=$(( cp - 1 ))
         [[ ${cp} == 0 ]] && cp=${tn}
         ;;

      "$ad")
         cp=$(( cp + 1 ))
         [[ ${cp} == $(( tn + 1 )) ]] && cp=1
         ;;

      "$nl")
         si=true
         end=true
         ;;

      "q")
         si=false
         end=true
         ;;

   esac

   tput cuu ${tn}

done

tput cud $(( tn - 1 ))
tput cnorm # unhide cursor
echo "$reset" # normal colors

} >&2 # end capture

${si} && eval "echo \$${cp}"

# eof
}

echo -e "$bold Which email address should be configured for this repo?"
email=$(menu_items ${MAILS});

git config user.email ${email}

exit 0
