FROM docker.io/bitnami/laravel:8

USER root

# COPY --chown=bitnami:bitnami . /app

COPY --chown=root:root ./app-entrypoint.sh /
COPY --chown=root:root instantclient_12_1 /opt/bitnami/instantclient_12_1
COPY --chown=bitnami:bitnami initialized.sem /tmp
COPY --chown=root:root ./php.oci.ini /opt/bitnami/php/etc/conf.d
COPY --chown=root:root ./oci8-2.2.0.tgz /tmp/oci8-2.2.0.tgz

RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list
RUN cat /etc/apt/sources.list
RUN rm -Rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get clean
RUN install_packages autoconf
RUN install_packages build-essential
RUN install_packages gcc
RUN install_packages vim
RUN install_packages libaio*

ENV LD_LIBRARY_PATH="/opt/bitnami/instantclient_12_1"

RUN cd /tmp \
    && ln -s /opt/bitnami/instantclient_12_1/libclntsh.so.12.1 /opt/bitnami/instantclient_12_1/libclntsh.so \
    && tar xzf oci8-2.2.0.tgz \
    && cd oci8-2.2.0 \
    && phpize \
    && ./configure --with-oci8=instantclient,/opt/bitnami/instantclient_12_1 \
    && make \
    && make install

USER bitnami
