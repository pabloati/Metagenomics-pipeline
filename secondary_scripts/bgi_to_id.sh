#!/bin/bash

if [[ $# != 1 ]]; then
        echo "Missing the directory where the files are stored"
        exit
fi

# Change IFS (Internal Field Separator) to tab to read TSV file
IFS=$'\t'

mkdir -p results/metaphlan/$1/id_profiles
# Loop through the TSV file and copy files to target directories with target names
while read -r file target_dir target_name; do
    target_name=$(echo "$target_name" | tr -d '\r')
    time=$(echo "$target_dir" | cut -d "_" -f 2)
    # Use cp command to copy file to target directory with target name
        #for n in 11350045 20391316 25841865 27763052 41952700 ; do
        #       cp results/metaphlan/$1/profiles/${file}_metagenome_${n}.txt results/metaphlan/$1/id_profiles/${target_name}_metagenome_${n}.txt
        #done
        cp results/metaphlan/$1/profiles/${file}_metagenome_42000000.txt results/metaphlan/$1/id_profiles/${target_name}_profiled_metagenome.txt
done < IDs_associations.txt
