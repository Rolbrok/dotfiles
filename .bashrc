#
# ~/.bashrc
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && exit 1

eval $(dircolors ~/.dircolors)
alias ls='ls --color=auto'

alias wget='wget --header="Accept: text/html" --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0"'

export GOPATH=/home/rolbrok/.go
export HOME_PATH=/home/rolbrok/.bin
export PANEL_PATH=/home/rolbrok/.config/bspwm/panel
export PATH=$PATH:$HOME_PATH:$PANEL_PATH:$GOPATH/bin

color_one='\[\e[30;42m\]'
color_two='\[\e[0;32m\]'
color_reset='\[\033[0m\]'

if [ -z "$terminal" ]; then terminal=""; fi

if [ "$terminal" != "logon" ]; then
    PS1="[$USER] \w \`if [ \$? = 0 ]; then echo '>'; else echo '\e[31m>\e[m'; fi\` "
else
    PS1="\e[32mHACKBOX >\e[m "
    terminal=""
fi

alias ll="ls -lah"
alias subl="subl3"
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"
alias emacs="emacs -nw"
alias em="emacs"
alias pcat="pygmentize -f terminal256 -O style=native -g"
alias archey="archey3"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias camshot="camshot -o ~"

alias pi_ncmpcpp='ncmpcpp -h 192.168.0.101'
alias pi_mpc='mpc -h 192.168.0.101 --pass mpd'
alias pi_disk="ssh 192.168.0.101 -t -t 'export PATH=$PATH:/home/rolbrok/.bin && disk'"

alias pi_bash="ssh 192.168.0.101 -t -t 'export TERM=xterm && tmux attach -t bg'"
alias pi_osmc="pi '' osmc"

export LESS='-R'

translate(){ wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'; }

duplicate() {
    find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate
}

arglen() {
    i=0
    for z in {1..100}; do
        if [ ! -z "${!z}" ]; then
            i=$(($i+1))
        else
            echo $i
            break
        fi
    done
    #echo $i
}

getargs() {
    l=$(arglen $@)
    args=""
    for i in $(seq $l); do
        if [ ${#args} -eq 0 ]; then
            args="${!i}"
        else
            args="$args|${!i}"
        fi
    done
    echo $args
}

calc() {
python << EOF
from math import *

arguments = "$(getargs "$@")"

args = []
for v in arguments.split('|'):
    try:
        exec("d = {0}".format(v))
        args.append(float(d))
    except:
        args.append(v)

for x, i in enumerate(args):
    print(i, end="")
    if x < len(args)-1:
        print(end=" ")
print()
EOF
}

motd() {
cat /etc/motd
echo "$USER, we meet again."
}

welcome() {
echo -ne '\e[32m'
cat << EOF

 ##############################################################################
 #                                                                            #
 #                                                                            #
 #                                                                            #
 #                      Welcome on your computer, sir.                        #
 #                                                                            #
 #                                                                            #
 #                                                                            #
 ##############################################################################

EOF
echo -ne '\e[m'
}

Xcolors() {
cols=$(cat ~/.Xdefaults | grep color | grep -v "!" | sed -e 's/\*//g' | sed -e 's/ color/\ncolor/g')
i=1
var=""
while [ $i -lt 32 ]
do
    var+=$(echo $cols | ft -f $i,$(($i+1)))
    var+="\n"    
    i=$(($i+2))
done
i=0
while [ $i -lt 8 ]
do
    res=$(echo -ne "$var" | grep "color$i:")
    echo -ne "\033[0;3${i}m$res █████████\033[m : 3${i}"
    res+=" "
    res=$(echo -ne "$var" | grep "color$(($i+8)):")
    echo -e " \033[0;9${i}m$res\t █████████\033[m : 9${i}"
    i=$(($i+1))
done
}

dx() {
    echo $(df -h $1 | ft -n 2 | ft -z -f $2 | sed -e 's/G//g')
}

disks() {
    echo "Disk usage:"
   
    root_one=$(dx / 3)
    root_two=$(dx / 2)
    echo -e "/: \t\t\e[0;92m${root_one}G/${root_two}G\e[m\t\t$(loading_bar_c $root_one $root_two 10 \#)"
    
    home_one=$(dx /home 3)
    home_two=$(dx /home 2)
    echo -e "/home: \t\t\e[0;92m${home_one}G/${home_two}G\e[m\t\t$(loading_bar_c $home_one $home_two 10 \#)"
 
    storage_one=$(dx /storage 3)
    storage_two=$(dx /storage  2) 
    echo -e "/storage: \t\e[0;92m${storage_one}G/${storage_two}G\e[m\t$(loading_bar_c $storage_one $storage_two 10 \#)"
    
    code_one=$(dx /code 3)
    code_two=$(dx /code 2)
    echo -e "/code: \t\t\e[0;92m${code_one}G/${code_two}G\e[m\t$(loading_bar_c $code_one $code_two 10 \#)" 
}

export EDITOR="vim"
alias svim="sudo vim"

conf() {
    case $1 in
        bspwm)      vim ~/.config/bspwm/bspwmrc ;;
        sxhkd)      vim ~/.config/sxhkd/sxhkdrc ;;
        mpd)        vim ~/.mpdconf ;;
        ncmpcpp)    vim ~/.ncmpcpp/config ;;
        pacman)     svim /etc/pacman.conf ;;
        ranger)     vim ~/.config/ranger/rc.conf ;;
        vim)        vim ~/.vimrc ;;
        xinit)      vim ~/.xinitrc ;;
        xresources) vim ~/.Xdefaults && xrdb ~/.Xdefaults ;;
        hosts)      sudoedit /etc/hosts ;;
        vhosts)     sudoedit /etc/httpd/conf/extra/httpd-vhosts.conf ;;
        httpd)      sudoedit /etc/httpd/conf/httpd.conf ;;
        *)          echo "Unknown application: $1" ;;
    esac
}

awesome() {
    echo -e "\033[0;37m$(uname -a | ft -f 3 | ft -n 1)\033[m- \033[0;34m$(uname -a | ft -f 2 | ft -n 1)\033[m"
    echo -e "\e[0;37m---- COLORS ----\e[m"
    colors
    echo -e "\e[0;37m---- DISKS ----\e[m"
    disk
}

bat() {
status="$(battery | ft -f 1)"
if [ "$status" == "Discharging" ]; then
    f_bat=$(acpi -V | ft -n 2 -f 13 | sed -e 's/\%//g')
    echo "Full battery life: $f_bat%"
    c_bat=$(acpi | ft -f 4 | ft -d '%' -f 1)
    echo "Current battery: $c_bat%"
    echo "Real battery: $(calc "$c_bat*($f_bat/100)")%"
    t="$(acpi | ft -f 5)"
    full=$(calc "($(hours $t)*100)/$(battery | ft -f 2)")
    echo "Battery time at 100%: $(hours $full)"
else
    if [ -z "$1" ]; then wanted="90"; else wanted="$1"; fi
    c_time="$(acpi | ft -f 5)"
    charge="$(battery | ft -f 2)"
    speed="$(calc "(100-$charge)/$(hours $c_time)" | ft -f 1)"
    hours=$(hours $(calc "($wanted-$charge)/$speed"))

    printf "Charge speed: %.2f %%/h\n" "$speed"
    echo "Charge E.T.A: $hours"
fi

}

pi() {
    if [ -z "$2" ]; then
        ssh 192.168.0.101 "$1"
    else
        ssh $2@192.168.0.101 "$1"
    fi
}

bat_duration() {
    bat=$(battery)
    if [ ! -z "$1" ]; then
        m_status=$(echo $bat | ft -f 1)
        bat=$(echo $bat | ft -f 2) 
       
        if [ $m_status == "Discharging" ]; then
            m_time="$(acpi | ft -f 5)"
            m_time="$(hours $m_time)"

            speed=$(calc "$bat/$m_time" | ft -f 1)
            echo "Discharging Speed: $speed %/h"      
            eta=$(calc "$(($bat-$1))/$speed" | ft -f 1)
            echo "E.T.A: $(hours $eta)"            
        elif [ $m_status == "Charging" ]; then
            m_time="$(acpi | ft -f 5)"
            m_time="$(hours $m_time)"

            speed=$(calc "(100-$bat)/$m_time" | ft -f 1)
            echo "Charging Speed: $speed %/h"      
            eta=$(calc "$(($1-$bat))/$speed" | ft -f 1)
            echo "E.T.A: $(hours $eta)"            

        fi
    fi    
}
