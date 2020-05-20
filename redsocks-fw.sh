#!/bin/sh

##########################
# Setup the Firewall rules
##########################
fw_setup() {
  iptables -t nat -N REDSOCKS
  iptables -t nat -A REDSOCKS -d 0.0.0.0/8 -j RETURN
  iptables -t nat -A REDSOCKS -d 10.0.0.0/8 -j RETURN
  iptables -t nat -A REDSOCKS -d 127.0.0.0/8 -j RETURN
  iptables -t nat -A REDSOCKS -d 169.254.0.0/16 -j RETURN
  iptables -t nat -A REDSOCKS -d 172.16.0.0/12 -j RETURN
  iptables -t nat -A REDSOCKS -d 192.168.0.0/16 -j RETURN
  iptables -t nat -A REDSOCKS -d 224.0.0.0/4 -j RETURN
  iptables -t nat -A REDSOCKS -d 240.0.0.0/4 -j RETURN

  iptables -t nat -A REDSOCKS -p tcp --dport 80 -j REDIRECT --to-ports 12346
  iptables -t nat -A REDSOCKS -p tcp --dport 443 -j REDIRECT --to-ports 12346

  iptables -t nat -A OUTPUT -p tcp -j REDSOCKS

  iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDSOCKS
  iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDSOCKS
}

##########################
# Clear the Firewall rules
##########################
fw_clear() {
  iptables-save | grep -v REDSOCKS | iptables-restore
}

case "$1" in
    start)
        echo -n "Setting REDSOCKS firewall rules..."
        fw_clear
        fw_setup
        echo "done."
        ;;
    stop)
        echo -n "Cleaning REDSOCKS firewall rules..."
        fw_clear
        echo "done."
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
        ;;
esac
exit 0

