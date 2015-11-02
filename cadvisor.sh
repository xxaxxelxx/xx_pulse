docker run --volume=/var/run:/var/run:rw --volume=/sys:/sys:ro -v /var/lib/docker/:/var/lib/docker:ro --publish=8080:8080 --detach=true --name=cadvisor google/cadvisor:latest
