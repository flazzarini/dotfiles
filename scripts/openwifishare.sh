ETH0ADD="192.168.0.2"
ETH0NET="255.255.255.0"

# Deactivate ufw
sudo /etc/init.d/ufw stop
sudo iptables -F

# Bring up Ethernet connection for sharing
sudo ifconfig eth0 down
sudo ifconfig eth0 up
sudo ifconfig eth0 $ETH0ADD netmask $ETH0NET

# Next we need to activate IP forwarding, and setup iptables to NAT:
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE

# The following may be worth trying if the client gets Host Prohibited responses:
sudo iptables -F FORWARD
sudo iptables -A FORWARD -j ACCEPT
sudo iptables -nvL
