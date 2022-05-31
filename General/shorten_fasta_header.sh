#If a line starts with > then remove everything after the first space
sed '/^>/s/^>\([^ ]*\) .*/>\1 /' $1 > $2

