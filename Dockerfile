FROM daseinji/ipfs-dns-delpoy:1.0.6

COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
