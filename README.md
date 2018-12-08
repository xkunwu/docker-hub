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
-   make sure all sh files are executable!
    ```
    find . -type f -name "*.sh" -exec chmod +x {} \;
    ```
