FROM daseinji/ipfs-cluster-ctl:1.0.6 
MAINTAINER dasein <acidpictures@gmai.com>

COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
