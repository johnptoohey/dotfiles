#!/bin/bash

set -e

sudo apt-get install -yy --no-install-recommends postfix

AUG_POSTFIX_CF=/tmp/hardened_postfix.cf
cp /etc/postfix/main.cf /tmp/hardened_postfix.cf
cat <<EOF >> $AUG_POSTFIX_CF

# only allow local clients to send mail, let them send to anywhere
smtpd_client_restrictions = permit_mynetworks, reject
smtpd_sender_restrictions = permit_mynetworks, reject
smtpd_recipient_restrictions = permit_mynetworks, reject
EOF

sudo cp $AUG_POSTFIX_CF /etc/postfix/main.cf
rm $AUG_POSTFIX_CF
sudo /etc/init.d/postfix restart
