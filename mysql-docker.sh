# Oracle MySQL

docker volume create oracle8

docker run --name mysql8 --restart always \
-v oracle8:/var/lib/mysql -v /etc/mysql-cont:/etc/mysql/conf.d \
-e MYSQL_ROOT_PASSWORD='NykArNq1' -e MYSQL_USER=super_user -e MYSQL_PASSWORD='NykArNq' -e MYSQL_DATABASE=super_db \
-v /home/db/dbinit:/docker-entrypoint-initdb.d \
-p 3307:3306 -d mysql:8.4

docker exec -ti mysql8 sh -c 'exec mysql super_db -uroot -p"$MYSQL_ROOT_PASSWORD"'
docker exec -i mysql8 sh -c 'exec mysql super_db -uroot -p"$MYSQL_ROOT_PASSWORD"' < t.sql
docker exec -i mysql8 sh -c 'exec mysqldump super_db -uroot -p"$MYSQL_ROOT_PASSWORD"' > dump.sql

docker stop mysql8; docker rm mysql8
docker rmi mysql:8.4
docker volume rm oracle8

# MariaDB
docker volume create maria11

docker run --name maria11 --restart always \
-v maria11:/var/lib/mysql -v /etc/maria-cont:/etc/mysql/conf.d \
-e MARIADB_ROOT_PASSWORD='NykArNq1' -e MARIADB_USER=super_user -e MARIADB_PASSWORD='NykArNq' -e MARIADB_DATABASE=super_db \
-v /home/db/dbinit:/docker-entrypoint-initdb.d \
-p 3308:3306 -d mariadb:11.4

docker exec -ti maria11 sh -c 'exec mysql super_db -uroot -p"$MARIADB_ROOT_PASSWORD"'
docker exec -i maria11 sh -c 'exec mysql super_db -uroot -p"$MARIADB_ROOT_PASSWORD"' < t.sql
docker exec -i maria11 sh -c 'exec mysqldump super_db -uroot -p"$MARIADB_ROOT_PASSWORD"' > dump.sql

docker stop maria11
docker rm maria11
docker rmi mariadb:11.4
docker volume rm maria11

# Percona MySQL
docker volume create percona8

docker run -d --name ps --restart always -e MYSQL_ROOT_PASSWORD='NykArNq1' \
-e MYSQL_USER=super_user -e MYSQL_PASSWORD='NykArNq' -e MYSQL_DATABASE=super_db \
-v percona8:/var/lib/mysql -v /etc/percona-cont:/etc/my.cnf.d \
-p 3309:3306 \
percona/percona-server:8.4

docker exec -ti ps sh -c 'exec mysql super_db -uroot -p"$MYSQL_ROOT_PASSWORD"'
docker exec -i ps sh -c 'exec mysql super_db -uroot -p"$MYSQL_ROOT_PASSWORD"' < sakila-0schema.sql
docker exec -i ps sh -c 'exec mysql super_db -uroot -p"$MYSQL_ROOT_PASSWORD"' < sakila-data.sql
docker exec -i ps sh -c 'exec mysqldump super_db -uroot -p"$MYSQL_ROOT_PASSWORD"' > dump.sql

docker stop ps; docker rm ps
docker rmi percona/percona-server:8.4
docker volume rm percona8

docker volume ls
docker network ls
docker images

# Docker compose
docker compose up -d
docker compose rm -fsv
docker volume rm 