FROM alpine:latest
EXPOSE 389

ENV UDPLOGHOST=
ENV TCPLOGHOST=
# The rsyslog package for alpine has no omrelp support
#ENV RELPLOGHOST=

RUN apk --update add openldap
RUN apk --update add openldap-back-monitor
RUN apk --update add openldap-back-hdb
RUN apk --update add openldap-back-bdb
RUN apk --update add openldap-back-ldap
RUN apk --update add openldap-back-meta
RUN apk --update add openldap-clients
RUN apk --update add rsyslog

RUN mkdir -m 0755 -p /var/spool/rsyslog &&  addgroup syslog && adduser -D -s /sbin/nologin -h /var/spool/rsyslog -G syslog syslog && chown -R syslog:syslog /var/spool/rsyslog 

# /var/cache/bind needs to be owned by "bind"
# since we are mounting, do it manually
# NOTE: Per Dockerfile manual --> need to mkdir the mounted dir to chown
RUN mkdir -m 0755 -p /etc/openldap /var/lib/openldap /var/run/slapd && chown -R ldap:ldap /etc/openldap /var/lib/openldap /var/run/slapd

# Mounts
# NOTE: Per Dockerfile manual -->
#	"if any build steps change the data within the volume
# 	 after it has been declared, those changes will be discarded."
VOLUME ["/var/spool/rsyslog"]
VOLUME ["/etc/rsyslog"]
VOLUME ["/etc/openldap"]
VOLUME ["/var/lib/openldap"]

COPY entrypoint.sh /
COPY rsyslog.conf /etc/rsyslog.conf

ENTRYPOINT ["/entrypoint.sh"]
