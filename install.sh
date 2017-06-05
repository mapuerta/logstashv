CHDIR="/opt"
NAMEDIR="logstash"
VERSION="5.4.0"
URL="https://artifacts.elastic.co/downloads/logstash/logstash-${VERSION}.zip"
DPKG_DEPEND="openjdk-8-jre wget ruby rubygems-integration"
INIT=/etc/init.d/

apt-get update && apt-get install ${DPKG_DEPEND} -y

if [ -d ${CHDIR}/${NAMEDIR} ]; then
    exit 0
fi
wget ${URL} -O ${CHDIR}/${NAMEDIR}.zip
unzip ${CHDIR}/${NAMEDIR}.zip -d ${CHDIR}
mv ${CHDIR}/${NAMEDIR}-${VERSION} ${CHDIR}/${NAMEDIR}
mkdir ${CHDIR}/${NAMEDIR}/logs
ln -sfv ${CHDIR}/${NAMEDIR}/logs/* /var/log/.
cp logstashd ${INIT} && chmod +x ${INIT}/logstashd

