docker run --mount type=bind,source=%cd%/mount/user1/tomcat/logs,target=/home/user1/tomcat/logs ^
--mount type=bind,source=%cd%/mount/user2/tomcat/logs,target=/home/user2/tomcat/logs ^
-p 8080:8080 -p 18080:18080 -dit --name %1 %1
