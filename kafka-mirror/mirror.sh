#!/bin/sh

function usage {
	cat >&2 <<EOF
Usage:
	$(basename ${0}) [<OPTIONS>] [<KAKFA_MIRROR_OPTIONS>]

OPTIONS:
	--name, -n        set container image name. (default: mirror)
	--host, -H        set container name. (default: mirror)
	--consumer, -c    set consumer config. (default: ./consumer.properties)
	--producer, -p    set producer config. (default: ./producer.properties)

KAFKA_MIRROR_OPTIONS: see kafka-mirror-maker.sh --help
	--blacklist <Java regex (String)>
	--new.producer
	--num.producers <Integer: Number of producers>
	--num.streams <Integer: Number of threads>
	--queue.size <Integer: Queue size in terms of number of messages>
	--white.list <Java regex (String)>
	
EOF
}

function build_container {
	docker build -t ${CONTAINER_NAME:-"mirror"} .
}

### main ---------------------------------------------------

while [ $# -gt 0 ]
do
	case ${1} in
		-d)
			set -x
			;;
		--name|-n)
			IMAGE_NAME=${2}
			shift
			;;
		--host|-H)
			CONTAINER_NAME=${2}
			shift
			;;
		--consumer|-c)
			CONSUMER_CONFIG=${2}
			shift
			;;
		--producer|-p)
			PRODUCER_CONFIG=${2}
			shift
			;;
		--help|-h)
			usage
			exit 0
			;;
		*)
			break
			;;
	esac
	shift
done

### image check
if [ $(docker images -q ${IMAGE_NAME:-"mirror"})"x" == "x" ]
then
	echo "build container ${IMAGE_NAME:-"mirror"}."
	build_container
fi

### run container
docker rm -f ${CONTAINER_NAME:-"mirror"} > /dev/null 2>&1
echo -e "run container: "
docker run -d \
	--name ${CONTAINER_NAME:-"mirror"} \
	--hostname ${CONTAINER_NAME:-"mirror"} \
	${IMAGE_NAME:-"mirror"}
if [ $? != 0 ]
then
	echo "[ERROR] docker conatainer cannot running.."
	exit 1
fi

### push kafka-mirror-maker options.
if [ $# -gt 0 ]
then
	echo "$@"
	for OPTION in $@
	do
		docker exec -i mirror \
			/bin/bash -c "echo -n ' '${OPTION} >> /tmp/kafka-mirror-maker.opt"
	done
fi

### push config files.
docker exec -i mirror \
	/bin/bash -c "cat >> /opt/kafka/config/consumer.properties" \
	< ${CONSUMER_CONFIG:-"./consumer.properties"}
docker exec -i mirror \
	/bin/bash -c "cat >> /opt/kafka/config/producer.properties" \
	< ${PRODUCER_CONFIG:-"./producer.properties"}

# EOF
