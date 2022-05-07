#!/bin/bash

#apply firewall rules
if [ "$IPTABLES_ENABLED" == "1" ];
then
  echo "starting iptables"
  iptables-restore < /etc/iptables/rules.v4
fi

#start transmission
if [ "$TRANSMISSION_ENABLED" == "1" ];
then
  echo "starting transmission"
  echo -e 'ENABLE_DAEMON=1\nCONFIG_DIR="/etc/transmission-daemon"\nOPTIONS="--config-dir $CONFIG_DIR"\n' > /etc/default/transmission-daemon
  /etc/init.d/transmission-daemon start
fi

#wireguard
if [ "$WG0_ENABLED" == "1" ];
then
  echo "starting wg0..."
  wg-quick up wg0
fi

/usr/sbin/cron -f

