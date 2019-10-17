FROM postgres:9.6.15-alpine


# do all in one step
RUN set -ex && \
    apk --no-cache add curl=7.66.0-r0 ca-certificates=20190108-r0 bash=5.0.0-r0 && \
    #Added  by Alex \
    #Alex added --no-cache
    apk --no-cache add net-tools=1.60_git20140218-r2 nano=4.3-r0 && \
    rm -rf /tmp/* /var/cache/apk/*

#Alex
#disable coloring for nano, see https://stackoverflow.com/a/55597765/1137529
RUN echo "syntax \"disabled\" \".\"" > ~/.nanorc; echo "color green \"^$\"" >> ~/.nanorc

#work-arround for nano
#Odd caret/cursor behavior in nano within SSH session,
#see https://github.com/Microsoft/WSL/issues/1436#issuecomment-480570997
ENV TERM eterm-color

COPY conf/init-databases.sh /docker-entrypoint-initdb.d/init-databases.sh
COPY conf/init-locking.sh /docker-entrypoint-initdb.d/init-locking.sh
COPY conf/init-lockingPermits.sh /docker-entrypoint-initdb.d/init-lockingPermits.sh


#docker rmi -f postgress
#docker rm -f manageDb
#docker build --squash . -t postgress
#docker run --name manageDb -d -p5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=main postgress
#smoke test
#docker exec -it $(docker ps -q -n=1) ps aux | grep 'postgres: checkpointer'
#docker exec -it $(docker ps -q -n=1) bash
#docker tag object-store-db alexberkovich/alpine-postgress:0.0.1
#docker push alexberkovich/alpine-postgress

# EOF