#!/bin/bash
set -e
ARTIFACT=DO
TARGET_DIR="/usr/local/bin"
VM2_IP="192.168.56.102"
DEPLOY_USER="deploy"
scp -i /home/gitlab-runner/.ssh/id_ed25519 $ARTIFACT ${DEPLOY_USER}@${VM2_IP}:${TARGET_DIR}/


ssh -i /home/gitlab-runner/.ssh/id_ed25519 ${DEPLOY_USER}@${VM2_IP} "${TARGET_DIR}/${ARTIFACT} 1"


