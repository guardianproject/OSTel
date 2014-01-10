kamailio Cookbook
=================
Set up a secure SIP server acording to OSTN standards. Inspired by the Asipto
document titled [Run your own Skype-like service in less than one hour](http://kb.asipto.com/kamailio:skype-like-service-in-less-than-one-hour)

To handle the SIPS socket, this cookbook will make the system where it is run an
SSL Certificate Authority. It is the operator's responsibility to distribute the
root certificate to all client applications. If you wish to have a commercially signed CA Certificate, you need to tak extra steps with your SSL vendor.

Requirements
------------

The only dependency is a Fully Qualified Domain Name (FQDN[http://en.wikipedia.org/wiki/FQDN]). THIS IS CRUCIAL! The
cookbook sets many parameters passed to scripts to this value, including the SIP registrar.
If you do not set a FQDN everything will break.

Unfortunately, the process to do this is varied, poorly documented and
mysterious. Basically, if you create a DNS A record for example.com pointing to
your IP address, you must configure the server so that the output of `hostname
-f` is <i>exactly</i> the same name.

On my testbed system, I did this by setting /etc/hostname to the FQDN and adding
a line in /etc/hosts to the IP address/hostname pair. Reboot. Type `hostname
-f`. If you get the output of the FQDN. You may run this cookbook.
