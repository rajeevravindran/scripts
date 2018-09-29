#!/bin/sh
# This script generates an Apache virtualhost config proxying all requests to an https url specific to a port. 
cat << EOF
<IfModule mod_ssl.c>
	<VirtualHost *:443>
		ServerAdmin webmaster@localhost
		ServerName $1.rajeevhome.net
		ServerAlias www.$1.rajeevhome.net
		LogLevel info ssl:warn
		ErrorLog ${APACHE_LOG_DIR}/error.log
		CustomLog ${APACHE_LOG_DIR}/access.log combined
		SSLEngine on
		SSLCertificateFile	/etc/apache2/certificates/$1.rajeevhome.net.pem
		SSLProxyEngine on
		SSLProxyVerify none 
		SSLProxyCheckPeerCN off
		SSLProxyCheckPeerName off
		SSLProxyCheckPeerExpire off
		ProxyPass / https://localhost:$2/
		ProxyPassReverse / https://localhost:$2/
		ProxyRequests on
	</VirtualHost>
</IfModule>
EOF
