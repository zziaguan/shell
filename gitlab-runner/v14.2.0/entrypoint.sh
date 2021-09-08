#!/bin/bash
# gitlab-runner data directory
DATA_DIR="/etc/gitlab-runner"
CONFIG_FILE=${CONFIG_FILE:-$DATA_DIR/config.toml}
# custom certificate authority path
CA_CERTIFICATES_PATH=${CA_CERTIFICATES_PATH:-$DATA_DIR/certs/ca.crt}
LOCAL_CA_PATH="/usr/local/share/ca-certificates/ca.crt"

update_ca() {
  echo "Updating CA certificates..."
  cp "${CA_CERTIFICATES_PATH}" "${LOCAL_CA_PATH}"
  update-ca-certificates --fresh >/dev/null
}

if [ -f "${CA_CERTIFICATES_PATH}" ]; then
  # update the ca if the custom ca is different than the current
  cmp --silent "${CA_CERTIFICATES_PATH}" "${LOCAL_CA_PATH}" || update_ca
fi

echo "hello" | tee /demo.txt


gitlab-runner register --non-interactive \
    --url ${GITLAB_URL}/ci \
    --registration-token ${CI_TOKEN} \
    --name runner-prod \
    --tag-list ${TAG_NAME} \
    --run-untagged=true \
    --executor docker \
    --builds-dir /home/gitlab-runner \
    --config "/etc/gitlab-runner/config.toml"

echo "gitlab-runner register finish" | tee /demo.txt

# launch gitlab-runner passing all arguments
exec gitlab-runner "$@"