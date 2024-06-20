certdir='/etc/kubernetes/ssl/'
if [ -d /etc/kubernetes/certs/ ]
then
	  certdir='/etc/kubernetes/certs/'
fi

for i in `ls $certdir|grep -v key`; do
  enddate=$(openssl x509 -in ${certdir}$i -noout -enddate| sed 's/^\([^=]*\)= *\(.*\)/\2/'|xargs -i date -d "{}" +'%Y-%m-%d.%H%M%S.GMT')
  echo $i $enddate
done
