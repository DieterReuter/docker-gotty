
# Pull base image
FROM alpine:3.7

# Set glibc version and other ENVs
ENV GLIBC_VERSION=2.26-r0 \
    LANG=C.UTF-8

# Install everything in a single step
RUN set -ex && \
    # Step 1: install glibc \
    \
    #--- install build dependencies --- \
    apk add --no-cache ca-certificates curl libstdc++ && \
    \
    #--- install glibc --- \
    curl -o /etc/apk/keys/sgerrand.rsa.pub -sSL https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION}; do curl -sSL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done && \
    apk add /tmp/*.apk && \
    \
    #--- set locale to UTF-8 --- \
    ( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ) && \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
    \
    \
    # Step 2: install GoTTY pre-compiled binary \
    \
    #--- install binary --- \
    curl -sSL -O https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz && \
    tar xvf /gotty_linux_amd64.tar.gz && \
    rm -f /gotty_linux_amd64.tar.gz && \
    \
    \
    # Step 3: install additional dependencies and packages \
    apk add --no-cache jq && \
    \
    #--- remove build dependencies --- \
    apk del glibc-bin glibc-i18n && \
    rm -rf /tmp/* /var/cache/apk/*

# Set standard start command for GoTTY
CMD ["/gotty", "--permit-write", "--reconnect", "/bin/ash"]
