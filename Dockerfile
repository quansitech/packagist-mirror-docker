FROM webysther/composer-debian

ARG PUID=1000
ARG PGID=1000

ENV PUID ${PUID}
ENV PGID ${PGID}
ENV TZ=UTC
ENV SLEEP=300

RUN groupadd -g ${PGID} packagist \
    && useradd -u ${PUID} -g packagist -m packagist \
    && usermod -p "*" packagist -s /bin/bash \
    && chown -R packagist:packagist /home/packagist \
    && echo "" >> ~/.bashrc \
    && echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> ~/.bashrc \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

USER packagist

RUN echo "" >> ~/.bashrc \
    && echo 'export PATH="~/.composer/vendor/bin:$PATH"' >> ~/.bashrc \
    && echo "" >> ~/.bashrc && echo 'export PATH="/var/www/vendor/bin:$PATH"' >> ~/.bashrc

USER root

ADD ./docker/worker/sync.sh /home/root/sync.sh

COPY . /var/www

WORKDIR /var/www
