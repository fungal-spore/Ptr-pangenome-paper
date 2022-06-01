#If a line starts with > then remove everything after the first space
sed '/^>/s/^>\([^ ]*\) .*/>\1 /' $1 | sed 's/\s//g' > $2


