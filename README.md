# samba
docker image from alpine


Usage with docker swarm

docker stack deploy -c docker-compose.yml "name of service"


docker-compose.yml
version: '3.3'

services:
  samba:
    image: zembi4/samba:alpine
    stdin_open: true
    tty: true
    volumes:
    - ./conf/smb.conf:/etc/samba/smb.conf
    - ./share:/share
    - /etc/localtime:/etc/localtime:ro
    networks:
      - outside
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure


networks:
  outside:
    external:
      name: "host"
