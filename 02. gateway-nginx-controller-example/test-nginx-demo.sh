curl -s http://35.199.50.44/ | grep "Server" | sed 's/<[^>]*>//g' | sed 's/&nbsp;/ /g'
