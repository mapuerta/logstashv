CHDIR="/opt"
NAMEDIR="logstash"
VERSION="5.4.0"
URL="https://artifacts.elastic.co/downloads/logstash/logstash-${VERSION}.zip"
DPKG_DEPEND="openjdk-8-jre wget ruby rubygems-integration"
INIT=/etc/init.d/

apt-get update && apt-get install ${DPKG_DEPEND} -y

JAVAVERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}'| cut -c 1-3)

if [ 1 -eq $(echo "(1.8 - ${JAVAVERSION}) > 0" | bc) ]; then
    echo "The java version should be 1.8\n"
    exit 1
fi


if [ ! -d ${CHDIR}/${NAMEDIR} ]; then
    wget ${URL} -O ${CHDIR}/${NAMEDIR}.zip
    unzip ${CHDIR}/${NAMEDIR}.zip -d ${CHDIR}
    mv ${CHDIR}/${NAMEDIR}-${VERSION} ${CHDIR}/${NAMEDIR}
    mkdir ${CHDIR}/${NAMEDIR}/logs
    ln -sfv ${CHDIR}/${NAMEDIR}/logs/* /var/log/.
fi


cp logstashd ${INIT} && chmod +x ${INIT}/logstashd
if [ ! -d /etc/logstash ]; then
    mkdir /etc/logstash
fi
cp logstash.conf /etc/logstash/logstash.conf
