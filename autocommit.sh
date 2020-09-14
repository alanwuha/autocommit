#!/bin/bash
####################
#
# Autocommit script.
#
####################

# Print start status message
echo "Starting autocommit"
date
echo

# Generate a random number between 5 to 10
rnumber=$((RANDOM%17+3))
echo "Pushing ${rnumber} commits on $(date)"

# Declare associate array for ordinals
declare -A ordinals=( [1]="First" [2]="Second" [3]="Third" [4]="Fourth" [5]="Fifth" [6]="Sixth" [7]="Seventh" [8]="Eighth" [9]="Ninth" [10]="Tenth" [11]="Eleventh" [12]="Twelveth" [13]="Thirteenth" [14]="Fourteenth" [15]="Fifteenth" [16]="Sixteenth" [17]="Seventeenth" [18]="Eighteenth" [19]="Nineteenth" [20]="Twentieth" )

# Create commit template with first commit
output="\n<details>"
output+="\n    <summary>Pushing <b>${rnumber}</b> commits on <b>$(date '+%a %d %b %Y')</b></summary>"
output+="\n\n    $(date '+%r'): First commit for the day"
output+="\n</details>"
echo -e "${output}" >> README.md
git add README.md
git commit -m "First commit for the day"

# Create remaining commits
for (( i=2; i<=$rnumber; i++ ))
do
    sed -i '$d' README.md
    output="    $(date '+%r'): ${ordinals[${i}]} commit for the day"
    output+="\n</details>"
    echo -e "${output}" >> README.md
    git add README.md
    git commit -m "${ordinals[${i}]} commit for the day"
done

# Push commits to github repository
git push

# Print end status message
echo
echo "Autocommit finished"
date
