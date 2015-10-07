# Kafka MirrorMaker

run kafka-mirror-maker.sh .

## Help

    Usage:
        mirror.sh [<OPTIONS>] [<KAKFA_MIRROR_OPTIONS>]
    
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

## 1. config

### Source Kafka Cluster.

use consumer.properties.

    zookeeper.connect=127.0.0.1:2181
    group.id=mirror

### Dest Kafka Cluster.

use producer.properties.

    metadata.broker.list=localhost:9092

## 2. run mirror.sh

    $ ./mirror.sh