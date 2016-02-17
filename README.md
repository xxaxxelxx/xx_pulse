# ***PULSE***
# Pulse reports player machines statuses to the active load balancer.
# Part of Dockerized Distributed Streaming System

[xxaxxelxx/xx_pulse](https://index.docker.io/u/xxaxxelxx/xx_pulse/)

## Synopsis
This repo is the base for an [automated docker build](https://hub.docker.com/r/xxaxxelxx/xx_pulse/) and is part of a dockerized distributed streaming system consisting of following elements:
* [xxaxxelxx/xx_pulse](https://github.com/xxaxxelxx/xx_pulse)
* [xxaxxelxx/xx_bridgehead](https://github.com/xxaxxelxx/xx_bridgehead)
* [xxaxxelxx/xx_coverter](https://github.com/xxaxxelxx/xx_converter)
* [xxaxxelxx/xx_customerweb](https://github.com/xxaxxelxx/xx_customerweb)
* [xxaxxelxx/xx_geograph](https://github.com/xxaxxelxx/xx_geograph)
* [xxaxxelxx/xx_icecast](https://github.com/xxaxxelxx/xx_icecast)
* [xxaxxelxx/xx_liquidsoap](https://github.com/xxaxxelxx/xx_liquidsoap)
* [xxaxxelxx/xx_loadbalancer](https://github.com/xxaxxelxx/xx_loadbalancer)
* [xxaxxelxx/xx_logsplitter](https://github.com/xxaxxelxx/xx_logsplitter)
* [xxaxxelxx/xx_pulse](https://github.com/xxaxxelxx/xx_pulse)
* [xxaxxelxx/xx_reflector](https://github.com/xxaxxelxx/xx_reflector)
* [xxaxxelxx/xx_rrdcollect](https://github.com/xxaxxelxx/xx_rrdcollect)
* [xxaxxelxx/xx_rrdgraph](https://github.com/xxaxxelxx/xx_rrdgraph)
* [xxaxxelxx/xx_sshdepot](https://github.com/xxaxxelxx/xx_sshdepot)
* [xxaxxelxx/xx_sshsatellite](https://github.com/xxaxxelxx/xx_sshsatellite)

The running docker container provides a service for very special streaming purposes usable for a distributed architecture.
It presumably will not fit for you, but it is possible to tune it. If you need some additional information, please do not hesitate to ask.

This [xxaxxelxx/xx_pulse](https://hub.docker.com/r/xxaxxelxx/xx_pulse/) repo is an essential part of a complex compound used for streaming.
This module reports the current status of a playing icecast machine to the active load balancer.

### Example
```bash
$docker run -d --name pulse -v /tmp:/host/tmp -v /proc/net/dev:/host/proc/net/dev:ro -v /proc/stat:/host/proc/stat:ro -e UPDATE_ADMIN_PASS=ADMINPASS -e BW_LIMIT=20000 -e LOAD_LIMIT=60 -e LOADBALANCER_ADDR=AAA.BBB.CCC.DDD -e LOOP_SEC=5 --link icecast_player:icplayer --restart=always xxaxxelxx/xx_pulse
```
***

## License

[MIT](https://github.com/xxaxxelxx/xx_Liquidsoap/blob/master/LICENSE.md)
