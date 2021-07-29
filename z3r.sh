#!/bin/bash

function patch() {
    local input=$1
    local output=$2

    if [ -z "$input" ]
    then
        echo $input
        echo $output
        cp $input $output
    else
        output=$input
    fi

    asar --no-title-check LTTP_RND_GeneralBugfixes.asm $output
}

patch $1 $2