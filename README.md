# Wemeet in Docker

## Limitations

- Configurations such as login state cannot persist. For unknown reasons, old configurations are invalid in new containers.
- I don't know if it is secure to bind mount `$XDG_RUNTIME_DIR`, without which the application would exit immediately.

## Acknowledgement

- https://github.com/mviereck/x11docker/wiki/Short-setups-to-provide-X-display-to-container