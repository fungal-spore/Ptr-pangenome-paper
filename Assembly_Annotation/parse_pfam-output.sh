#remove the header
sed '1,28d' $1 > $1.pfamout2

# count and order unique instances of each string in columns 6, 7 and 8
awk '{print $6}' $1.pfamout2 | sort | uniq -c | sort -nr > $1.hmmacc.count
awk '{print $7}' $1.pfamout2 | sort | uniq -c | sort -nr > $1.hmmname.count
awk '{print $8}' $1.pfamout2 | sort | uniq -c | sort -nr > $1.hmmtype.count
awk '{print $15}' $1.pfamout2 | sort | uniq -c | sort -nr > $1.clan.count
rm $1.pfamout2
