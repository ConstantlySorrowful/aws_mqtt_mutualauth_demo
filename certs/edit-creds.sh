#!/bin/bash
export PATH="$PWD:$PATH"
#echo $PATH
cert=`ls /home/studio/workspace/local/*-cert*`
priv=`ls /home/studio/workspace/local/*-priv*`
sed -z 's/\n/\\n/g;s/^/export CLIENT_CERTIFICATE_PEM=\"/;s/\(export CLIENT_CERT.*\)\\n$/\1\"\n/' $cert > cert.str
sed -z 's/\n/\\n/g;s/^/export CLIENT_PRIVATE_KEY_PEM=\"/;s/\(export CLIENT_PRIV.*\)\\n$/\1\"\n/' $priv > priv.str
cat cert.str >> secrets.txt
cat priv.str >> secrets.txt

source secrets.txt 
cd ../amazon-freertos/demos/include
envsubst <aws_clientcredential.h.in >aws_clientcredential.h
envsubst <aws_clientcredential_keys.h.in >aws_clientcredential_keys.h

cd -
cd ../Socket/WiFi
envsubst <socket_startup.c.in >socket_startup.c
