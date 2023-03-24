# Wemeet in Docker

## Limitations

- Webcam does not work. Even though `abc` is added to `video` group and apps such as `vlc` worked perfectly, `wemeet` would still get permission errors opening `/dev/video0`.
- Configurations such as login state cannot persist. For unknown reasons, old configurations are invalid in new containers.
- I don't know if it is secure to bind mount `$XDG_RUNTIME_DIR`, without which the application would exit immediately.

## Acknowledgement

- https://github.com/mviereck/x11docker/wiki/Short-setups-to-provide-X-display-to-container