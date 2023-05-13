FROM --platform=linux/amd64 node:16.13
MAINTAINER dasein <acidpictures@gmai.com>


WORKDIR /tmp

ENV CLUSTER_VERSION v1.0.6
ENV CLUSTER_TAR ipfs-cluster-ctl_${CLUSTER_VERSION}_linux-amd64.tar.gz

# Fix certificates
RUN apt-get update && apt-get install -y ca-certificates libgnutls30 wget && update-ca-certificates

RUN set -x \
  && wget "https://dist.ipfs.io/ipfs-cluster-ctl/$CLUSTER_VERSION/$CLUSTER_TAR" \
  && tar -xzf "$CLUSTER_TAR" --strip-components=1 ipfs-cluster-ctl/ipfs-cluster-ctl \
  && mv ipfs-cluster-ctl /usr/local/bin
