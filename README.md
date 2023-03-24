# IPFS GitHub Action

Publish websites to IPFS as part of a github action workflow. This action pins a directory to IPFS by using the ipfs-cluster-ctl command to pin it to a remote IPFS Cluster. It sets the IPFS URL as a status on the commit that triggered the action, allowing easy previewing of rendered static sites on the dweb.

Simplified and slightly improved version of https://github.com/ipfs-shipyard/ipfs-github-action.

## Usage

Use this action from a workflow that build out your static site to a directory. In this example we ask ipfs-github-action to pin the `public` dir in the current workspace to cluster.ipfs.io

```yaml
- uses: ipfs-shipyard/ipfs-github-action@v2
  id: ipfs
  with:
    path_to_add: public
    cluster_host: /dnsaddr/cluster.ipfs.io
    cluster_user: ${{ secrets.CLUSTER_USER }}
    cluster_password: ${{ secrets.CLUSTER_PASSWORD }}

# "bafkreicysg23kiwv34eg2d7qweipxwosdo2py4ldv42nbauguluen5v6am"
- run: echo /ipfs/${{ steps.ipfs.outputs.cid }}

# https://bafkreicysg23kiwv34eg2d7qweipxwosdo2py4ldv42nbauguluen5v6am.ipfs.dweb.link
- run: echo ${{ steps.ipfs.outputs.url }}
```

## Inputs

### `path_to_add`

**Required** The path the root directory of your static website or other content that you want to publish to IPFS.

### `cluster_user`

Username for the IPFS Cluster instance

### `cluster_password`

Password for the IPFS Cluster instance

### `cluster_host`

**Required** Multiaddr for the IPFS Cluster. - see: https://cluster.ipfs.io/
_Default_ `/dnsaddr/cluster.ipfs.io`

### `wait_for_pin`

Wait until data become pinned
_Default_ `false`

### `ipfs_gateway`

**Required** IPFS subdomain gateway to use for preview url - see: https://docs.ipfs.io/concepts/ipfs-gateway
_Default_ `dweb.link`

## Outputs

### `cid`

The IPFS content identifier for the directory on IPFS.
e.g. `bafkreicysg23kiwv34eg2d7qweipxwosdo2py4ldv42nbauguluen5v6am`

More info on CIDs: https://docs.ipfs.io/concepts/content-addressing/

### `url`

The URL for the IPFS gateway to preview the content over https.
e.g. https://bafkreicysg23kiwv34eg2d7qweipxwosdo2py4ldv42nbauguluen5v6am.ipfs.dweb.link

More info on IPFS Gateways: https://docs.ipfs.io/concepts/ipfs-gateway

## License

[MIT](LICENSE)

[`ipfs-cluster-ctl`]: https://cluster.ipfs.io/documentation/ipfs-cluster-ctl/
[`entrypoint.sh`]: scripts/pin-to-cluster.sh
