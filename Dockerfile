FROM grahamgilbert/ubuntu-ssh
ENV SSH_INHERIT_ENVIRONMENT=true
RUN apt-get update && apt-get install -y wget automake autotools-dev g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config && git clone https://github.com/s3fs-fuse/s3fs-fuse

WORKDIR s3fs-fuse
RUN ./autogen.sh && ./configure --prefix=/usr --with-openssl && make && make install && mkdir -p /data && chmod 777 /data
WORKDIR /
ADD mount-s3.sh /mount-s3.sh
RUN rm -rf /s3fs-fuse && chmod +x /mount-s3.sh
ADD s3fs.conf /etc/supervisord.d/s3fs.conf
