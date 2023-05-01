#-------------------------------------------------------------------
# Helpers
_get-container-name(){
    echo $(docker ps $@  --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Ports}}" | _fzf-show --header-lines=1 --no-preview | awk '{print $3}')
}

#-------------------------------------------------------------------
# Docker
#

docker-ip(){
  container=$(_get-container-name)
  [ -z "${container}" ] && return
  docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'  $container
}

docker-logs(){
    container_name=$(_get-container-name -a)
    [ -z "${container_name}" ] && return
    docker logs --follow --details --tail 1800 $container_name | ccze -m ansi | less
}

_if_container_run(){
    id=$1

    if_run=$(docker ps -a --filter "id=$id" | tail -n +2 | awk '{print $1}')

    if [[ -z "${if_run-unset}" ]]; then
        echo "container '$id' does not exist"
    else
        echo "Container: $id"
    fi
}

docker-volume-named-backup(){
    echo "Crea un backup de un volumen nombrado."

    VOLUME_NAMED=$(docker volume ls | _fzf-show --no-preview --prompt 'Volume> ' --header-lines=1 --no-preview | awk '{print $2}')
    [ -z "${VOLUME_NAMED}" ] && return
    echo "docker run --rm -v $VOLUME_NAMED:/backup:ro -v $(pwd):/source busybox tar -zcvf /source/$VOLUME_NAMED--$(date +%Y-%m-%d__%H.%M)-backup.tar.gz /backup/*"
    docker run --rm -v $VOLUME_NAMED:/backup:ro -v $(pwd):/source busybox tar -zcvf /source/$VOLUME_NAMED--$(date +%Y-%m-%d__%H.%M)-backup.tar.gz -C /backup .
}


docker-volume-backup(){
    echo "Crea un backup de un volumen que sea usado por algún contenedor."

    CONTAINER_NAME=$(_get-container-name)
    [ -z "${CONTAINER_NAME}" ] && return
    VOLUME_PATH=$(docker inspect $CONTAINER_NAME | jq --raw-output '.[ ] .Config.Volumes | keys[]' |  _fzf-show --no-preview --prompt 'Volume> ')
    [ -z "${VOLUME_PATH}" ] && return
    docker run --rm --volumes-from $CONTAINER_NAME -v $(pwd):/backup busybox tar -zcvf /backup/$CONTAINER_NAME--$(date +%Y-%m-%d__%H.%M)-backup.tar.gz $VOLUME_PATH
}

docker-volume-named-backup-restore(){
    read "volume_named? Ingrese el nombre que se le asignara al nuevo volumen nombrado:  "
    read "file_backup? Ingrese la ruta del backup (.tar.gz), para el volumen '$volume_named': "
    echo -e "\nSe ejecutara:"
    echo -e "docker run --rm -i -v $volume_named:/backup busybox tar -xzC /backup <$file_backup\n\n"
    docker run --rm -i -v $volume_named:/backup busybox tar -xzC /backup <$file_backup
}

docker-volume-backup-restore(){
    # first create a container that uses a backup volume
    # new_container must have the same volume name than old container
    NEW_CONTAINER_NAME=$(_get-container-name)
    file_backup=$(fd -t f -H -E "$FZF_IGNORE" |  _fzf-show --no-preview --prompt "Get backup.tar.gz ($NEW_CONTAINER_NAME)> " )
    file_backup=$(echo $file_backup| sed -e '1s/^..//')

    echo -e "\nSe ejecutara:"
    echo -e "docker run --rm --volumes-from $NEW_CONTAINER_NAME -v $(pwd):/backup busybox tar -xzvf /backup/$file_backup\n\n"
    docker run --rm --volumes-from $NEW_CONTAINER_NAME -v $(pwd):/backup busybox tar -xzkvf "/backup/$file_backup"
}

# Containers
docker-restart(){
    id_container=$(docker ps -a  --format "table {{.ID}}\t{{.Image}}\t{{.Names}}" | fzf --header-lines=1 --no-preview --height 100% --ansi --border -q "$1" | awk '{print $1}')
    [ -z "${id_container}" ] && return
    docker restart $id_container
}

docker-exec(){
    id_container=$(docker ps  --format "table {{.ID}}\t{{.Image}}\t{{.Names}}" | fzf --header-lines=1 --no-preview --height 100% --ansi --border -q "$1" | awk '{print $1}')
    [ -z "${id_container}" ] && return
    docker exec -it $id_container sh
}


docker-start() {
  id_container=$(docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Names}}" | grep -v 'Up' | fzf --header-lines=1 --no-preview --height 100% --ansi --border -q "$1" | awk '{print $1}')

  [ -z "${id_container}" ] && return

  for id in $(echo $id_container); do
      docker start $id
      docker attach $id
  done

}

docker-stop() {

  container=$1

  if [ -z "${container}" ]; then
      id_container=$(docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Names}}" | fzf --header-lines=1 --no-preview --height 100% --ansi --border -q "$1" | awk '{print $1}')

      [ -z "${id_container}" ] && return

      for id in $(echo $id_container); do
          docker stop $id
      done
  else
    docker stop $container
  fi
}

docker-remove-container() {
  id_container=$(docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"  | fzf --header-lines=1 --no-preview --height 100% --ansi --border -q "$1" | awk '{print $1}')

  [ -z "${id_container}" ] && return

  for id in $(echo $id_container); do
      if_run=$(docker ps -a --filter "id=$id" | tail -n +2 | awk '{print $1}')


      if [[ -z "${if_run-unset}" ]]; then
          echo "container '$id' does not exist"
      else
          echo "Container: $id"
          docker-stop $id
          docker rm $id
      fi
  done
}


# Images
docker-remove-image(){
    id_images=$(docker images | fzf --header-lines=1 --no-preview --height 100% --ansi --border -q "$1" | awk '{print $3}')

    [ -z "${id_images}" ] && return

    for id in $(echo $id_images); do
        docker rmi $id
    done
}

docker-template(){
    bash ~/.oh-my-zsh/custom/scripts/docker-template.sh $@
}
