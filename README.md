# Docker server
> The main purpose is to provide OpenAI's Gym with Tensorflow and GUI.

## Images
### Base
-   User control (unprivileged)
-   VNC (tightvncserver)
-   GUI (xfce4).

### CUDA
-   CUDA 9.0 (with CUDNN 7)
-   Python: Miniconda

### Tensorflow
-   Build from the source

## NOTE
-   Make sure all sh files are executable! Otherwise do the similar after deploy (in the container).
    ```
    find . -type f -name "*.sh" -exec chmod +x {} \;
    ```
