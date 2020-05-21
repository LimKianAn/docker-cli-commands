curl -o docker-stack.yml https://raw.githubusercontent.com/dockersamples/example-voting-app/master/docker-stack.yml
docker stack deploy --compose-file docker-stack.yml my_stack
docker stack ps my_stack
docker stack services my_stack
docker service scale my_stack_vote=10 # better change the docker-stack.yml directly
docker stack services my_stack
docker service inspect my_stack_vote --pretty
docker service ps my_stack_vote