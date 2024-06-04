echo 'Creating an upload keystore'

# Set the keystore password
export KEYSTORE_PASSWORD=OyJyJCDl8xxVPvbn9Mt123
# Set the key alias
export KEY_ALIAS=upload
# Set the key password
export KEY_PASSWORD=OyJyJCDl8xxVPvbn9Mt123
# Set the keystore file name
export KEYSTORE_FILE=android/app/upload-keystore.jks
# Set the keystore information
export STORE_TYPE=JKS
export KEY_ALGORITHM=RSA
export KEY_SIZE=2048
export VALIDITY=10000
# Set the CN (common name), OU (organizational unit), O (organization), L (city or locality), ST (state or province), and C (country code)
export CN="PGlobal"
export OU="PGlobal"
export O="PGlobal"
export L="Manila"
export ST="NCR"
export C="PH"

# Generate the keystore
keytool -genkeypair -v \
  -keystore $KEYSTORE_FILE \
  -storetype $STORE_TYPE \
  -keyalg $KEY_ALGORITHM \
  -keysize $KEY_SIZE \
  -validity $VALIDITY \
  -alias $KEY_ALIAS \
  -keypass $KEY_PASSWORD \
  -storepass $KEYSTORE_PASSWORD \
  -dname "CN=$CN, OU=$OU, O=$O, L=$L, ST=$ST, C=$C"

echo 'Done creating an upload keystore'