BASE_DIR="$(pwd)"
PASSWORD="gini@321"
COUNTRY="IN"
STATE="KARNATAKA"
CITY="BANGALORE"
ORG="GINIMINDS"
DEPARTMENT="DSP"
NODE="172.16.16.104"
EMAIL="kafka@giniminds.com"
DAYS=365
ALIAS="SERVERSIDE"
KSNAME="server.keystore.jks"
CA_EXTERNAL_FILE="ca-extfile.cnf"
SERVER_CERT_FILE="server-cert-file"
SERVER_CERT_SIGNED="server-cert-signed"

keytool -keystore client.truststore.jks -alias CARoot -import -file "${BASE_DIR}"/ca-cert -storepass $PASSWORD -noprompt

keytool -genkeypair \
  -alias "${ALIAS}" \
  -keyalg RSA -keysize 2048 \
  -keystore "${KSNAME}" \
  -dname "CN=${NODE}, OU=${DEPARTMENT}, O=${ORG}, L=${CITY}, S=${STATE}, C=${COUNTRY}" \
  -storepass "${PASSWORD}" -keypass "${PASSWORD}" \
  -validity ${DAYS}

keytool -keystore "${KSNAME}" -alias "${ALIAS}" -certreq -file "${SERVER_CERT_FILE}" -storepass "${PASSWORD}"
echo subjectAltName = IP:"${NODE}" >> "${CA_EXTERNAL_FILE}"
openssl x509 -req -CA "${BASE_DIR}"/ca-cert -CAkey "${BASE_DIR}"/ca-key -in "${BASE_DIR}"/"${SERVER_CERT_FILE}" -out "${SERVER_CERT_SIGNED}" -days ${DAYS} -CAcreateserial -extfile "${BASE_DIR}"/"${CA_EXTERNAL_FILE}" -passin pass:"${PASSWORD}"
keytool -keystore "${KSNAME}" -alias CARoot -import -file "${BASE_DIR}"/ca-cert -storepass "${PASSWORD}" -noprompt -keypass "${PASSWORD}"
keytool -keystore "${KSNAME}" -alias "${ALIAS}" -import -file "${BASE_DIR}"/"${SERVER_CERT_SIGNED}" -storepass "${PASSWORD}" -noprompt
