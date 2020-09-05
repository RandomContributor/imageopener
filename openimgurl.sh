#!/usr/bin/env bash
help="usage:\n\t$0 <options>\n\t\t* [-i ~ the filename to be read from]\n\t\t[-m ~ the mode to be used (one of xdg-open direct-viewer browser ffplay workaround-1 workaround-2 wget)]\n\t\t[-w ~ arguments supplied to wget (default are -nv --show-progress)]\n\t\t[-d ~ suppress debug output]\n\t\t[-h ~ this help]"

. libopenimgurl.sh

input=""
mode="$(select_mode)"
wgetargs='-nv --show-progress'
debug=1

while getopts i:m:w:s:dh name; do 
    case $name in 
    i) 
        input="$(<OPTARG)";; 
    m) 
        mode="$OPTARG";; 
    w)
        wgetargs="$OPTARG";;
    d)
        debug=0;;
        
    ?|h) 
        echo -e "$help";; 
    esac
done
shift $((OPTIND - 1))

[[ $debug == 1 ]] && (
echo "mode is $mode"
echo "input is $input"
echo "wget args are ${wgetargs}"	
echo "prepare your anus"
)

case $mode in
less-retarded) parallel xdg-open <<<"${input}";;
xdg-open)     while IFS= read -r  line; do xdg-open "$line";done <"${input}";;
direct-viewer)while IFS= read -r  line; do $(select_viewer) "$line";done <"${input}";;
browser)      while IFS= read -r  line; do $(select_browser) "$line";done <"${input}";;
ffplay)       while IFS= read -r  line; do ffplay "$line";done <"${input}";;
workaround-1) while IFS= read -r  line; do wget -qO- "$line" | $(select_viewer) - ;done <"${input}";;
workaround-2) while IFS= read -r  line; do wget -qO/tmp/laksdfh "$line" | $(select_viewer) /tmp/laksdfh ;done <"${input}";;
wget|*)       while IFS= read -r  line; do wget $wgetargs ;done <"${input}";;

esac
