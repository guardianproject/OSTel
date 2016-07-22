# dump SIP traffic

# plaintext
ngrep -d eth0 -t -p -W byline port 5060

#encrypted hex dump
ngrep -d eth0 -x -t -p port 5061
