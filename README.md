# Wemeet in Docker

Run Tencent Meeting in Docker, providing isolation.

## Getting Started

System requirements: Linux with X display server (wayland not supported)

- Clone the repository or copy `docker-compose.yml` to host

- Allow access to X server from the container:

  ```sh
  xhost +SI:localuser:$(id -un)
  ```

- Set environment variables by altering `docker-compose.yml`

- `docker compose up -d` and `docker compose start` after the first startup

## Environment Variables

| Env | Required | Description | Example |
|-|-|-|-|
| `DISPLAY` | Yes | Should be the same as of the host | `$DISPLAY` |
| `XDG_RUNTIME_DIR` | Yes | Should be the same as of the host | `$XDG_RUNTIME_DIR` |
| `PUID`| Yes | The current user ID. Can be acquired by `id -u` | `1000` |
| `PGID`| Yes | The current user's group ID. Can be acquired by `id -g` | `1000` |
| `VIDEO_GID`| If you want webcam | ID of group `video`. Can be acquired by `getent group video` | `985` |

> The UID and GIDs can also be found by simply running `id` most of the time.

## Limitations

- Configurations such as login state cannot persist. For unknown reasons, old configurations are invalid in new containers.
- I don't know if it is secure to bind mount `$XDG_RUNTIME_DIR`, without which the application would exit immediately.
  - It seems that it is this mount that enables the audio feature.

## Acknowledgement

- https://github.com/mviereck/x11docker/wiki/Short-setups-to-provide-X-display-to-container