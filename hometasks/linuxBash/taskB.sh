#!/bin/bash

log_file="example_log.log"

#1. From which ip were the most requests?
ip_addresses=`awk '{print $1}' $log_file | sort | uniq -c | sort -n`
most_common_ip=`echo "$ip_addresses" | awk 'END{print $2}'`
echo "The most common IP address is: $most_common_ip"

echo "------------------------"

#2. What is the most requested page?
echo "The most requested page:"
awk '{print $7}' $log_file | sort | uniq -c | sort -nr | head -1

echo "------------------------"

#3. How many requests were there from each ip?
echo "IP addresses:"
awk '{print $1}' $log_file | sort | uniq -c | sort -nr

echo "------------------------"

#4. What non-existent pages were clients referred to
echo "Not found pages:"
grep " 404 " $log_file | awk '{print $7}' | sort | uniq -c

echo "------------------------"

#5. What time did site get the most requests?
hours=$(awk '{print $4}' $log_file | cut -d: -f2 | sort | uniq -c | sort -n | awk 'END{print $2}')
echo "The site received the most requests at hour $hours"

echo "------------------------"

#6. What search bots have accessed the site? (UA + IP)
grep -i "bot\|crawler" $log_file > bots.txt
echo "Unique user agents of search bots:"
cat bots.txt | awk '{print $1, $12}' | sort | uniq
rm bots.txt

