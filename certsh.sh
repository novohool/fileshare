certdir='/etc/kubernetes/ssl/'
if [ -d /etc/kubernetes/certs/ ]
then
  certdir='/etc/kubernetes/certs/'
fi

for i in `ls $certdir|grep -v key`; do
    openssl x509 -text -in ${certdir}$i | grep -A2 Validity |egrep "crt|After"| sed 's/^\([^:]*\): *\(.*\)/\2/' | while read -r date_str; do
        echo "$(basename $i):$(date -d "${date_str#*: }" +'%Y-%m-%d.%H%M%S.GMT')"
    done
done
