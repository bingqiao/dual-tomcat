docker build --rm --no-cache ^
--build-arg TOMCAT_MAJOR=8 ^
--build-arg TOMCAT_VERSION=8.5.34 ^
-t %1 .
