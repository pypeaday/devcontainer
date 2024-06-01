build-code-server:
  #!/bin/bash
  docker build -t nicpayne713/code-server -f code-server.Dockerfile .
push-code-server:
  #!/bin/bash
  docker push nicpayne713/code-server
build-devcontainer:
  #!/bin/bash
  docker build -t nicpayne713/devcontainer -f devcontainer.Dockerfile .
push-devcontainer:
  #!/bin/bash
  docker push nicpayne713/devcontainer
