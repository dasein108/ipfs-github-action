FROM ipfs/ipfs-dns-deploy:latest

COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
