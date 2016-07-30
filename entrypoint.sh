#!/bin/sh
mkdir -p /etc/rsyslog
cat /dev/null > /etc/rsyslog/00-remote.conf
[ -n "$UDPLOGHOST" ] && echo "*.* @$UDPLOGHOST" >> /etc/rsyslog/00-remote.conf
[ -n "$TCPLOGHOST" ] && echo "*.* @@$TCPLOGHOST" >> /etc/rsyslog/00-remote.conf
[ -n "$UDPLOGHOST" -o -n "$TCPLOGHOST" ] && /usr/sbin/rsyslogd -f /etc/rsyslog.conf
/usr/sbin/slapd -h "ldap:///"  -g ldap -u ldap -l DAEMON -d none
