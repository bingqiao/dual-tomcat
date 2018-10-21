docker build ^
--build-arg JAVA_VERSION=8u191 ^
--build-arg JAVA_BUILD=8u191-b12 ^
--build-arg JAVA_DL_HASH=2787e4a523244c269598db4e85c51e0c ^
--build-arg TOMCAT_MAJOR=8 ^
--build-arg TOMCAT_VERSION=8.5.34 ^
-t %1 .
