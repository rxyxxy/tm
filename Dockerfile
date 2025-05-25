# 使用 Ubuntu 22.04 作为基础镜像
FROM ubuntu:24.04

# 设置环境变量（防止交互式安装提示）
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要依赖（curl 用于下载 dotnet，libc6 运行依赖）
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    libicu-dev \
    libcurl4 \
    ca-certificates \
    htop \
    && rm -rf /var/lib/apt/lists/*

# 安装 .NET 5.0 Runtime（使用官方链接）
RUN mkdir -p /opt/dotnet && \
    curl -SL https://builds.dotnet.microsoft.com/dotnet/Runtime/5.0.16/dotnet-runtime-5.0.16-linux-x64.tar.gz \
    | tar -xz -C /opt/dotnet
RUN curl -SL http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.24_amd64.deb -o libssl1.1_1.1.1f-1ubuntu2.24_amd64.deb \
&& dpkg -i libssl1.1_1.1.1f-1ubuntu2.24_amd64.deb \
&& rm -f libssl1.1_1.1.1f-1ubuntu2.24_amd64.deb


ENV DOTNET_ROOT=/opt/dotnet
ENV PATH=$DOTNET_ROOT:$PATH

# 创建工作目录
WORKDIR /app

# 拷贝你的所有文件到容器中
COPY . /app

# 给 start.sh 添加执行权限
RUN chmod +x start.sh

# 设置容器启动命令
CMD ["./start.sh"]
