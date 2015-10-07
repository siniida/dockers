#!/bin/sh

echo "waiting config.."

while [ ! -f /opt/kafka/config/consumer.properties -o ! -f /opt/kafka/config/producer.properties ]
do
	sleep 1
done

if [ -f /tmp/kafka-mirror-maker.opt ]
then
	OPTIONS=$(cat /tmp/kafka-mirror-maker.opt)
fi

/opt/kafka/bin/kafka-mirror-maker.sh \
	--consumer.config /opt/kafka/config/consumer.properties \
	--producer.config /opt/kafka/config/producer.properties \
	${OPTIONS:-"--whitelist=\"*\""}
