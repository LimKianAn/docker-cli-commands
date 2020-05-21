# node a
docker swarm init
docker node ls
docker swarm join-token manager

# node b, c
docker swarm join --token SWMTKN-1-<cluster id>-<manager token> <ip>:2377

# node a
docker node ls
docker node demote <node-a-id> <node-b-id>

# node b, c
docker swarm leave

# node a
dockre swarm leave --force