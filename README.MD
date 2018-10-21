# Dual Tomcat Setup

Dockerfile to build two standalone Tomcat servers on CentOS 7

Please adapt cmd scripts to shell scripts to run on Linux.

Setup
-----

Different versions of jdk or tomcat can be used. Just modify the build.cmd accordingly.

To build the image

```bash
  build.cmd <name>
```

Launching Tomcat servers
--------------------

Create in current directory the two following directories:
* mount/user1/tomcat/logs
* mount/user1/tomcat/logs

```bash
  run.cmd <name>
```
Tomcat servers will run on port 8080 and 18080.

Run the following to connect to the container:

```bash
  exec.cmd <name>
```
