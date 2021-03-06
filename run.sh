#!/bin/bash

# Get s3 creds from env var and write to password file
echo "$S3_IDENTITY":"$S3_CREDENTIAL" >> /etc/passwd-s3fs
chmod 600 /etc/passwd-s3fs
# Mount s3 bucket from environment variable
mkdir -p /data
chmod 777 /data
su - ${OPTS_SSH_USER} -c "s3fs -o allow_other $S3_BUCKET /data"
chown -R ${OPTS_SSH_USER} /data
# Configure SSH
/usr/sbin/sshd-bootstrap

# Run SSH
/usr/sbin/sshd -D
