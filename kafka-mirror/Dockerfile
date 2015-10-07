FROM siniida/kafka
MAINTAINER siniida <sinpukyu@gmail.com>

RUN rm \
	/opt/kafka/config/consumer.properties \
	/opt/kafka/config/producer.properties \
	/usr/local/bin/entry.sh

ADD entry.sh /

ENTRYPOINT ["/entry.sh"]
