# node a
docker swarm init
docker swarm join-token manager

# node b, c
docker swarm join --token SWMTKN-1-<cluster id>-<manager token> <ip>:2377

# node a
docker network create --driver bridge kio
docker container run --name server -d --rm --network kio -p 8080:80 nginx
docker network inspect kio

# browser
<public dns>:8080

# node a
docker container stop <server container id> # the nginx above
docker network create --driver overlay republic
docker service create --name kiko --network republic --replicas 2 -d alpine sleep 1d
docker service ps kiko # shows node a, b

# node b
docker network inspect republic # shows <IPv4Address> of kiko, 10.0.1.9 in this case

# node a
docker container exec -it <kiko container id> sh

# in kiko sh
ping <IPv4Address> # 10.0.1.9 in this case
exit

# node a
docker service rm $(docker service ls --quiet)
docker service create -d --name aaa --network republic --replicas 3 alpine sleep 1d
docker service create -d --name bbb --network republic --replicas 3 alpine sleep 1d
docker service ls
docker container ls
docker container exec -it <aaa container id> sh

# in aaa sh
ping bbb
exit

# node a
docker service create -d --name nginx-server --network republic --replicas 1 -p 8080:80 nginx
docker service inspect nginx-server --pretty # shows "Ports"

# browser
<public dns of node a or b or c>:8080
