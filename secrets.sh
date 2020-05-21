# node a in a swarm
echo "RT" > classified
docker secret create secret-v0 classified
docker secret ls^
docker secret inspect secret-v0
docker service create -d --name secret-service --secret secret-v0 alpine sleep 1d
docker service ls
docker service inspect secret-service # shows "Secrets"
docker service ps secret-service # shows which node

# node c (in this case)
docker container ls
docker container exec -it 84 <container id>

# in secret-service sh
ls -l /run/secrets # on linux
cat /run/secrets/secret-v0
exit

# node c (any manager would do)
docker service rm secret-service
docker secret rm secret-v0
docker secret ls