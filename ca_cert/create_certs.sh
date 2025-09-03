CA_PASS="gini@321"
C="IN"
ST="KARNATAKA"
L="BANGALORE"
O="GINIMINDS"
OU="DSP"
CN="172.16.16.173"
EMAIL="kafka@giniminds.com"

openssl req -new -x509 \
  -keyout ca-key \
  -out ca-cert \
  -days 365 \
  -passout pass:$CA_PASS \
  -subj "/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=$CN/emailAddress=$EMAIL"
