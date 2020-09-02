#!/usr/bin/env bash

# If you are looking for something to run, this is the wrong place.



# easily user-editable, checked in order
# if you only want a specific one, use
# viewers=( "command4daviwve" )
# i recommend qiv if you would lik to avoid crashes
viewers=( "qiv" "viewnior"  "gpicview" "eom" )

# oh boy
browsers=(
# firefox and derivatives
"firefox" "icecat" "waterfox" "palemoon"
# chrome and derivatives
"chrome" "chromium" "chromium-browser" "ungoogled-chromium" "iridium" "vanadium"
# other browsers
"opera" "xombrero" "brave" # idk feel free to add more 
# cli browsers (but what's the point)
"links2" "links" "lynx" "w3m" "browsh" 
)

# requires a little more work to edit, may not be processed in order
modes=( "xdg-open" "direct-viewer" "browser" "ffplay" "workaround-1" "workaround-2" "wget" )

# checks whether a dependency is present
function check_dep() {
	for i in "$@";do
        ! which "$i" &>/dev/null && return 1
	done

	return 0
}

# u goteem image viewerz
function select_viewer() {
    for viewer in "${viewers[@]}";do
        check_dep "$viewer" && echo "$viewer" && return 0
    done
    
    return 1
}

# u goteem browserz
function select_browser() {
    for browser in "${browsers[@]}";do
        check_dep "$browser" && echo "$browser" && return 0
    done
    
    return 1
}

# mode nao ya lil shit
function select_mode() {
    for modei in "${modes[@]}";do
        case $modei in
        # prepare your anus
        # if you have xdg-open, you should be good
        xdg-open)
            check_dep "xdg-open" && echo "$modei" && return 0;; # <- I should probably make that a function

        # attempts to call the viewer directly with a url, may not end particularly well
        direct-viewer)
            select_viewer &>/dev/null && echo "$modei" && return 0;;

        # navigates a browser to the link
        browser)
            select_browser &>/dev/null && echo "$modei" && return 0;;

        # uses ffplay
        ffplay)
            check_dep "ffplay" && echo "$modei" && return 0;;

        # use these if your image viewer is too retarded for http
        workaround-.)
            check_dep "wget" && echo "$modei" && return 0;;

        # use wget for download
        wget|*)
            check_dep "wget" && echo "$modei" && return 0;;
        esac
    done
}
