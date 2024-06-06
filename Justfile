build-code-server:
  #!/bin/bash
  docker build -t pypeaday/code-server -f code-server.Dockerfile .
push-code-server:
  #!/bin/bash
  docker push pypeaday/code-server
build-devcontainer:
  #!/bin/bash
  docker build -t pypeaday/devcontainer -f devcontainer.Dockerfile .
push-devcontainer:
  #!/bin/bash
  docker push pypeaday/devcontainer
encrypt:
  #!/usr/bin/env bash
  set -euo pipefail
  ansible-vault encrypt stowme/.ssh/id_rsa --vault-password-file key
decrypt:
  #!/usr/bin/env bash
  set -euo pipefail
  ansible-vault decrypt stowme/.ssh/id_rsa --vault-password-file key