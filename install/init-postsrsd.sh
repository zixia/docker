#!/bin/bash

[ -d /etc/postsrsd/secret ] || {
    mkdir -p /etc/postsrsd/secret
}

cd /etc/postsrsd/secret

# skip generation of secret if one exists (by mounting a volume)
if [ ! -f "postsrsd.secret" ]; then
  tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c 128 > postsrsd.secret
fi

chown -R root:postsrsd /etc/postsrsd/secret/
chmod -R 750 /etc/postsrsd/secret/

echo "domains = {\"$SMF_DOMAIN\"}" >> /etc/postsrsd/postsrsd.conf
echo "secrets-file = \"/etc/postsrsd/secret/postsrsd.secret\"" >> /etc/postsrsd/postsrsd.conf

echo "Start postsrsd in background"
postsrsd &
