# docker build -t lambdanative:3.0 .
# docker run --rm -v $(pwd):/app lambdanative

#FROM microsoft/dotnet:2.2-sdk AS build-env
FROM buildpack-deps:bionic-scm

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        #libicu60 \
        libssl1.1 \
        libstdc++6 \
        #zlib1g \
        cmake \
        clang-3.9 \
        libicu-dev \
        uuid-dev \
        libcurl4-openssl-dev \
        libkrb5-dev \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

ENV DOTNET_SDK_VERSION 3.0.100-preview4-011223

RUN curl -SL --output dotnet.tar.gz https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$DOTNET_SDK_VERSION/dotnet-sdk-$DOTNET_SDK_VERSION-linux-x64.tar.gz \
    && dotnet_sha512='b416dd4014ad62c7d19413c44738f1cc6152c94570c31dc953be16bfeadecf449b2aab7ecc09c9d3fcd12b2d440f281a0c8f1ad0635bc035adb34c26f8d1e2ae' \
    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

WORKDIR /app
#RUN apt-get update && apt-get install cmake clang-3.9 libicu-dev uuid-dev libcurl4-openssl-dev zlib1g-dev libkrb5-dev -y
ENTRYPOINT ["dotnet", "publish", "-c", "Release", "-r", "linux-x64"]
