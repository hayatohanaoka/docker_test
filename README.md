# 目次
- [概要](#概要)
    - [参考記事](#参考記事)
    - [使用したコマンド](#使用したコマンド)
    - [ヘルプの出力内容](#ヘルプの出力内容)
- [各種ファイルの中身](#各種ファイルの中身)

# 概要
- Dockerでの環境構築の第一歩としての練習リポジトリ
    - WSL2 × windows を想定

### 参考記事
1. [WSLのインストール](https://learn.microsoft.com/ja-jp/windows/wsl/install)
2. [Dockerの環境構築](https://zenn.dev/ttani/articles/wsl2-docker-setup)
3. [Docker×Python環境構築](https://zenn.dev/agdm/articles/0f82ea448e38b8)

### 使用したコマンド
1. `docker -v`
    - 動作確認に使用
2. `docker --help > help.txt`
    - コマンドのヘルプを出すために使用
3. `docker image ls`
    - image の一覧情報の出力に使用
4. `docker container ls`
    -  container の一覧情報の出力に使用
5. **`docker-compose up -d --build`**
    - `Dockerfile` から `images` をビルドし、`Docker-compose.yml` に従って `containers` を2つ以上起動する際に使用
6. `docker container start [YOUR CONTAINER NAME]`
    - コンテナの起動に使用
7. **`docker container exec -it [YOUR CONTAINER NAME] bash`**
    - コンテナにbashで接続
8. `docker container stop [YOUR CONTAINER NAME]`
    - コンテナの停止に使用
9. `docker-compose down`
    - コンテナを停止して削除する際に使用

### ヘルプの出力内容（困ったら見てみる）
```
Usage:  docker [OPTIONS] COMMAND

A self-sufficient runtime for containers

Common Commands:
    run         Create and run a new container from an image
    exec        Execute a command in a running container
    ps          List containers
    build       Build an image from a Dockerfile
    pull        Download an image from a registry
    push        Upload an image to a registry
    images      List images
    login       Log in to a registry
    logout      Log out from a registry
    search      Search Docker Hub for images
    version     Show the Docker version information
    info        Display system-wide information

Management Commands:
    builder     Manage builds
    buildx*     Docker Buildx (Docker Inc., v0.12.1-desktop.4)
    compose*    Docker Compose (Docker Inc., v2.24.6-desktop.1)
    container   Manage containers
    context     Manage contexts
    debug*      Get a shell into any image or container. (Docker Inc., 0.0.24)
    dev*        Docker Dev Environments (Docker Inc., v0.1.0)
    extension*  Manages Docker extensions (Docker Inc., v0.2.22)
    feedback*   Provide feedback, right in your terminal! (Docker Inc., v1.0.4)
    image       Manage images
    init*       Creates Docker-related starter files for your project (Docker Inc., v1.0.1)
    manifest    Manage Docker image manifests and manifest lists
    network     Manage networks
    plugin      Manage plugins
    sbom*       View the packaged-based Software Bill Of Materials (SBOM) for an image (Anchore Inc., 0.6.0)
    scout*      Docker Scout (Docker Inc., v1.5.0)
    system      Manage Docker
    trust       Manage trust on Docker images
    volume      Manage volumes

Swarm Commands:
      swarm       Manage Swarm

Commands:
    attach      Attach local standard input, output, and error streams to a running container
    commit      Create a new image from a container's changes
    cp          Copy files/folders between a container and the local filesystem
    create      Create a new container
    diff        Inspect changes to files or directories on a container's filesystem
    events      Get real time events from the server
    export      Export a container's filesystem as a tar archive
    history     Show the history of an image
    import      Import the contents from a tarball to create a filesystem image
    inspect     Return low-level information on Docker objects
    kill        Kill one or more running containers
    load        Load an image from a tar archive or STDIN
    logs        Fetch the logs of a container
    pause       Pause all processes within one or more containers
    port        List port mappings or a specific mapping for the container
    rename      Rename a container
    restart     Restart one or more containers
    rm          Remove one or more containers
    rmi         Remove one or more images
    save        Save one or more images to a tar archive (streamed to STDOUT by default)
    start       Start one or more stopped containers
    stats       Display a live stream of container(s) resource usage statistics
    stop        Stop one or more running containers
    tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
    top         Display the running processes of a container
    unpause     Unpause all processes within one or more containers
    update      Update configuration of one or more containers
    wait        Block until one or more containers stop, then print their exit codes

Global Options:
    --config string      Location of client config files (default
                            "C:\\Users\\user\\.docker")
    -c, --context string     Name of the context to use to connect to the
                            daemon (overrides DOCKER_HOST env var and
                            default context set with "docker context use")
    -D, --debug              Enable debug mode
    -H, --host list          Daemon socket to connect to
    -l, --log-level string   Set the logging level ("debug", "info",
                            "warn", "error", "fatal") (default "info")
        --tls                Use TLS; implied by --tlsverify
        --tlscacert string   Trust certs signed only by this CA (default
                            "C:\\Users\\user\\.docker\\ca.pem")
        --tlscert string     Path to TLS certificate file (default
                            "C:\\Users\\user\\.docker\\cert.pem")
        --tlskey string      Path to TLS key file (default
                            "C:\\Users\\user\\.docker\\key.pem")
        --tlsverify          Use TLS and verify the remote
    -v, --version            Print version information and quit

Run 'docker COMMAND --help' for more information on a command.

For more help on how to use Docker, head to https://docs.docker.com/go/guides/
```

# 各種ファイルの中身
1. `.env`
    - 環境変数設定ファイル
    ```
    EXAMPLE_ENV_VALUE=******
    ```

2. `Dockerfile`
    - Dockerコンテナのイメージを構築するためのファイル
    ```
    # Pythonのイメージ
    FROM python:3.12.2
    USER root

    RUN apt-get update
    RUN apt-get -y install locales && \
        localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

    # 必要なパッケージをインストールする
    COPY requirements.txt ./ 
    RUN apt-get install -y vim less
    RUN pip install --upgrade pip
    RUN pip install --no-cache-dir -r requirements.txt
    ```

3. `docker-compose`
    - Dockerコンテナを起動するためのファイル
    ```
    services:
    pytho3:
        env_file: .env
        restart: always
        build: .
        working_dir: '/root/'
        tty: true
        volumes:
        - ./opt:/root/opt
    ```