#!/bin/sh
# sudo grep "Failed password for" /var/log/auth.log | grep -Po "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | sort | uniq -c
# sudo grep "Failed password for" /var/log/auth.log | grep -Po "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | sort | uniq
# sudo grep "Failed password for" /var/log/auth.log | grep -Po "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | sort | uniq | sed 's/.*/prefix & suffix/'

# Define file format:
file=block_ip_`date +'%Y-%m-%d_%H_%M_%S'`.sh

# Add to script '#!/bin/sh':
echo '#!/bin/sh' > $file

# Add commands to block IP:
sudo grep "Failed password for" /var/log/auth.log | grep -Po "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | sort | uniq | sed 's/.*/sudo iptables -A INPUT -s & -j DROP/' >> $file 

# Add edit for creator and executable permissions:
chmod 755 $file

# Check if not added important IP (they must be never blocked):
cat $file | grep 127.0.0.1      # localhost IP

