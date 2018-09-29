./generate.sh $1 >> $1.rajeevhome.net.ext
openssl genrsa -out $1.rajeevhome.net.key 2048
openssl req -new -key $1.rajeevhome.net.key -out $1.rajeevhome.net.csr
openssl x509 -req -in $1.rajeevhome.net.csr -CA rajeevhome.net.pem -CAkey rajeevhome.net.key -CAcreateserial -out $1.rajeevhome.net.crt -days 1825 -sha256 -extfile $1.rajeevhome.net.ext
cat $1.rajeevhome.net.key $1.rajeevhome.net.crt > $1.rajeevhome.net.pem
cp $1.rajeevhome.net.pem /etc/apache2/certificates/$1.rajeevhome.net.pem
./generate-apache.sh $1 $2 >> /etc/apache2/sites-available/$1.rajeevhome.net.conf
a2ensite $1.rajeevhome.net.conf
apachectl -configtest
service apache2 restart
