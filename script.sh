#!/bin/bash

# 1 = commit, 0 = no commit
pattern=(
    "00000000000000000000000000000000000000"
    "00011111001000100111110011111001000100"
    "00010001001000100100000000100000101000"
    "00011110001000100111110000100000010000"
    "00010001001000100000010000100000010000"
    "00010001001111100111110000100000010000"
    "00000000000000000000000000000000000000"
    
)

# Starting date (beginning of 2017)
start_date="2017-01-01"

# Iterate over rows and columns to generate commits
for row in {0..6}; do
    for col in {0..51}; do
        if [[ "${pattern[row]:col:1}" == "1" ]]; then
            # Calculate the current date based on row (day) and col (week)
            commit_date=$(date -j -v+"$((row + col * 7))d" -f "%Y-%m-%d" "$start_date" +"%Y-%m-%dT12:00:00")
            
            # Make multiple commits for darker squares
            for i in {1..10}; do
                echo "Commit $i on $commit_date" > file.txt
                git add file.txt
                GIT_AUTHOR_DATE="$commit_date" GIT_COMMITTER_DATE="$commit_date" git commit -m "Commit on $commit_date"
            done
        fi
    done
done

echo "Done! Push this repository to GitHub to see your graph."
