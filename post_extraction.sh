#!/bin/bash
regex="#[[:space:]]+VERSION[[:space:]]([0-9.]+)"
for BaseName in *; do
  if [ -d "${BaseName}" ]; then
    versionGrep=`grep -F "# VERSION" "${BaseName}/Dockerfile"`
    [[ $versionGrep =~ $regex ]]
    versionId="${BASH_REMATCH[1]}"
    if [ ${#versionId} != 0 ]; then
      versionString="v${versionId}"
      currentImages=`docker images ${BaseName}`

      dockerBuild=false
      removeExisting=false
      removableTags=""

      if [[ $currentImages == *"${BaseName}"* ]]; then
        if ! [[ $currentImages == *"${versionString}"* ]]; then
          removeExisting=true
          removableTags=`docker images ${BaseName} | grep -o 'v[0-9.]\+'`
          dockerBuild=true
        fi
      else
        dockerBuild=true
      fi

      if [[ "$dockerBuild" = true ]]; then
        docker build -t ${BaseName}:${versionString} ${BaseName}
      fi

      if [[ "$removeExisting" = true ]]; then
        # kill the container and yank the image
        docker stop ${BaseName}
        docker rm ${BaseName}

        for tag in ${removableTags//\\n/ }
        do
          removeName="${BaseName}:${tag}"
          docker rmi ${removeName}
        done
      fi

      currentRunning=`docker ps`
      if ! [[ $currentRunning == *"${BaseName}"* ]]; then
        docker rm ${BaseName}
        additionalargs=""
        if ! [ -f "${BaseName}/additional_args" ]
        then
          additionalargs=`cat ${BaseName}/additional_args`
        fi
        docker run -d --name ${BaseName} ${additionalargs} "${BaseName}:${versionString}"
      fi
    else
      echo "Docker file for ${BaseName} does not specify # VERSION"
    fi
  fi
done