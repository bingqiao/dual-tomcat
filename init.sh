#!/bin/bash

# run script after switching user
su - user1 << EOF
exec catalina.sh start
EOF

# run script after switching user
su - user2 << EOF
exec catalina.sh start
EOF

# stop container quitting
/bin/bash