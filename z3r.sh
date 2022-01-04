#!/bin/bash

function patch() {
    local input=$1
    local output=$2

    if [ -z "$input" ]
    then
        echo "Usage: z3r <input_path> [new_output_path]"
        return
    fi

    if [ ! -f "$input" ]; then
        echo "$input does not exist."
        return
    fi

    if [ -z "$output" ]
    then
        output=$input
    else
        cp $input $output
    fi

    # Absolute path to this script, e.g. /home/user/bin/foo.sh
    local script=$(greadlink -f "$0")
    # Absolute path this script is in, thus /home/user/bin
    script_path=$(dirname "$script")

    asar --no-title-check "${script_path}/LTTP_RND_GeneralBugfixes.asm" $output
}

patch $1 $2