FROM jbonachera/alpine
MAINTAINER Julien BONACHERA <julien@bonachera.fr>

EXPOSE 8200
ENTRYPOINT ["/sbin/entrypoint"]
RUN mkdir /etc/vault /etc/templates
RUN adduser  -S vault
RUN chown vault: -R /etc/vault/
RUN apk -U add curl bind-tools unzip
ENV VERSION=0.7.3
RUN curl -sLo /var/tmp/vault.zip https://releases.hashicorp.com/vault/${VERSION}/vault_${VERSION}_linux_amd64.zip  && \
    unzip /var/tmp/vault.zip -d /usr/local/sbin && rm -f /opt/vault.zip
RUN chmod +x /usr/local/sbin/vault
COPY vault.conf.j2 /etc/templates
COPY entrypoint /sbin/entrypoint
USER vault
