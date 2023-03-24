#!/bin/sh

# Interpolate env vars in the $INPUT_PATH_TO_ADD, see: https://docs.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#entrypoint
# This handles situation where user provides path to add as $GITHUB_WORKSPACE/some/path
INPUT_DIR=$(sh -c "echo $INPUT_PATH_TO_ADD")
PIN_NAME="https://github.com/$GITHUB_REPOSITORY/commits/$GITHUB_SHA"

echo "Pinning $INPUT_DIR to $INPUT_CLUSTER_HOST"

if [ -n "$INPUT_CLUSTER_USER" ] && [ -n "$INPUT_CLUSTER_PASSWORD" ]; then
  echo "Using basic auth"
  AUTH="--basic-auth $INPUT_CLUSTER_USER:$INPUT_CLUSTER_PASSWORD"
else
  echo "Using without auth"
fi

if [-n "$WAIT_FOR_PIN" ]; then
  echo "Waiting for pin to be replicated"
  WAIT=" --wait"
else
  echo "Skipping wait for pin to be replicated"
fi

# pin to cluster
root_cid=$(ipfs-cluster-ctl \
  --host "$INPUT_CLUSTER_HOST" \
  $AUTH \
  add \
  --quieter \
  --local \
  $WAIT \
  --no-stream \
  --cid-version 1 \
  --name "$PIN_NAME" \
  --recursive "$INPUT_DIR") || {
  echo "$root_cid" 1>&2
  echo "Failed to pin to cluster" 1>&2
  false
}

preview_url="https://$INPUT_IPFS_GATEWAY/ipfs/$root_cid"

echo "Pinned to IPFS - $preview_url"

echo "cid=$root_cid" >>$GITHUB_OUTPUT
echo "url=$preview_url" >>$GITHUB_OUTPUT
