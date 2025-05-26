# 使用 Alpine 作为基础镜像
FROM alpine:3.18

# 安装必要依赖（libc6 等是 glibc 的兼容版本）
RUN apk add --no-cache \
    curl \
    icu-libs

# 安装 gcompat 或 glibc 以兼容 .NET 的需求（Alpine 默认使用 musl，不支持 .NET）
RUN apk add --no-cache gcompat

# 安装 .NET 5.0 Runtime
RUN mkdir -p /opt/dotnet && \
    curl -SL https://builds.dotnet.microsoft.com/dotnet/Runtime/5.0.16/dotnet-runtime-5.0.16-linux-x64.tar.gz \
    | tar -xz -C /opt/dotnet

# 设置环境变量
ENV DOTNET_ROOT=/opt/dotnet
ENV PATH=$DOTNET_ROOT:$PATH

# 设置工作目录
WORKDIR /app

# 拷贝当前目录文件到容器
COPY . /app

# 添加执行权限
RUN chmod +x start.sh

# 设置启动命令
CMD ["./start.sh"]
