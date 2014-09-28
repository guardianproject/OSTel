This is the web application component of a larger software stack developed for [ostel.co](https://ostel.co), a Free and Open Source Software (FOSS)
secure voice and video calling service. It's also a simple user management front end to
[Kamailio](https://dev.guardianproject.info/projects/ostel/wiki/Kamailio), a modular SIP server.

_This application does not provide the complete stack to build your own secure SIP server!_ The process to stand up a production server is much more complicated. Please refer to the full [server documentation](https://dev.guardianproject.info/projects/ostel/wiki/Server_Documentation) if you are looking to make a custom domain on your own infrastructure.

This is a [Rails web application](https://dev.guardianproject.info/projects/ostel/wiki/Ruby_on_Rails) which manages a database shared with the [Kamailio SIP server](https://dev.guardianproject.info/projects/ostel/wiki/Kamailio).

One of the core features of ostel is [secure federation](https://dev.guardianproject.info/projects/ostel/wiki/Inter-domain_calling) between SIP domains. This means that user@example1.com can place calls to user@example2.com without the need to create accounts on both systems. You can compare this type of network to Jabber/XMPP, Diaspora and of course the venerable messaging system we all know and love, email.
