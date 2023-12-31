#!/bin/bash

# Check if a source file path and a destination file path were provided as arguments
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Please provide a source file path and a destination file path as arguments"
    exit 1
fi

# Set the source file path to the first argument and the destination file path to the second argument
src_file="$1"
dest_file="$2"

awk -F '\t' -v OFS='\t' 'NR==1 {
    for (i=1; i<=NF; i++) {
        if ($i=="sequence_id") c1=i;
        if ($i=="productive") c2=i;
        if ($i=="complete_vdj") c3=i;
        if ($i=="v_call") c4=i;
        if ($i=="j_call") c5=i;
        if ($i=="junction") c6=i;
        if ($i=="junction_aa") c7=i;
        if ($i=="consensus_count") c8=i;
        if ($i=="duplicate_count") c9=i
    }
    seq_id=0
    print "sequence_id", "productive", "complete_vdj", "v_call", "j_call", "junction", "junction_aa", "consensus_count", "duplicate_count"
}
NR>1 {
    if ($c1=="" || $c1=="NULL") {
        seq_id++;
        $c1=seq_id
    }
    if (substr($c7,1,1)=="C" && (substr($c7,length($c7),1)=="F" || substr($c7,length($c7),1)=="W")) {
        print $c1, $c2, $c3, $c4, $c5, $c6, $c7, $c8, $c9
    }
}' "$src_file" > "$dest_file"
