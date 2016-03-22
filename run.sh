#!/bin/bash

# Get s3 creds from env var and write to password file
echo "$S3_IDENTITY":"$S3_CREDENTIAL" >> /etc/passwd-s3fs
chmod 600 /etc/passwd-s3fs
# Mount s3 bucket from environment variable
mkdir -p $S3_LOCATION
s3fs $S3_BUCKET $S3_LOCATION

# Configure SSH
/usr/sbin/sshd-bootstrap

# Run SSH
/usr/sbin/sshd -D
