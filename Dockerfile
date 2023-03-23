FROM daseinji/ipfs-dns-delpoy:1.0.6
RUN chmod 775 $GITHUB_OUTPUT
COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
