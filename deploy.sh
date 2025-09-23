#!/bin/bash
set -e

scp -i /home/gitlab-runner/.ssh/id_ed25519 data-samples/DO deploy@192.168.56.102:/tmp/DO

ssh -i /home/gitlab-runner/.ssh/id_ed25519 deploy@192.168.56.102 "sudo install -m 755 /tmp/DO /usr/local/bin/DO && rm -f /tmp/DO && DO 1"

