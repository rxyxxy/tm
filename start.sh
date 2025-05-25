#!/bin/bash

curl ifconfig.me
echo
curl ifconfig.me

if command -v dotnet >/dev/null 2>&1; then
    echo "dotnet 已安装"
    dotnet /app/Cli.dll start accept --token $token 
else
    echo "dotnet 未安装"   
    wget https://builds.dotnet.microsoft.com/dotnet/Runtime/5.0.16/dotnet-runtime-5.0.16-linux-x64.tar.gz -O dotnet-runtime-5.0.16.tar.gz
    mkdir -p $HOME/dotnet5
    tar -xzf dotnet-runtime-5.0.16.tar.gz -C $HOME/dotnet5
    export DOTNET_ROOT=$HOME/dotnet5
    export PATH=$DOTNET_ROOT:$PATH
    dotnet /app/Cli.dll start accept --token $token
fi



