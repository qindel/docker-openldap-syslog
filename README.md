Docker container with openldap and syslog forwarding
Based on Alpine with a size of 15MB

NOTE: Example assumes you have a "/ldap" with your container specific data!
Change as needed with the SRC data that you are mounting into the container.
Example named data is defined in the example subdir.

## Required "DATA" directory - named.conf and zone data:
This container assumes you have a "/ldap" folder with your container specific data:
You can change that folder as needed, but make sure you update the "-v" mounts for run time

1.) [ *REQUIRED* ] In your /ldap/etc/openldap a file "slapd.conf", which acts as an entry point to your configs, or a directory slapd.d

2.) [ *REQUIRED* ] A "/ldap/var/lib/openldap" directory for the LDAP database

4.) [ *OPTIONAL* ] set environment variable "UDPLOGHOST" or "TCPLOGHOST", if defined rsyslog will be started with remote SYSLOG logging to these hosts. If you use remote syslog, then it might be useful to set the hostname of the container depending on your server syslog configuration (the logs on the syslog server might get stored based on the hostname of the client)


## Run slapd

```
docker run -i --name=ldapserver --hostname=ldapserver --rm -p 389:389 -e UDPLOGHOST=192.168.0.17  -v /ldap/var/lib/openldap:/var/lib/openldap  -v /ldap/etc/openldap:/etc/openldap qindel/openldap-syslog
```