docker container run -dit --name alpineWithVol --mount source=volOnHost,target=/vol alpine:latest
docker volume ls
sudo ls -l /var/lib/docker/volumes/volOnHost/_data
docker container exec -it alpineWithVol sh

# In alpineWithVol sh
ls -l /vol
echo "li ho" > /vol/new
cat /vol/new
exit

# Back to host
sudo cat /var/lib/docker/volumes/volOnHost/_data/new
docker container rm alpineWithVol -f
sudo cat /var/lib/docker/volumes/volOnHost/_data/new
docker container run -dit --name nginxWithVol --mount source=volOnHost,target=/app nginx
docker container exec -it nginxWithVol sh

# In nginxWithVol sh
cat /app/new
echo "li ma ho" >> /app/new
exit

# Back to host
sudo cat /var/lib/docker/volumes/volOnHost/_data/new
docker container rm -f nginxWithVol
sudo cat /var/lib/docker/volumes/volOnHost/_data/new
docker volume rm volOnHost
sudo ls /var/lib/docker/volumes