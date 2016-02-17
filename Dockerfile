FROM fedora
MAINTAINER Julien BONACHERA <julien@bonachera.fr>

EXPOSE 8200
CMD /usr/local/sbin/vault server -config /etc/vault/config -log-level trace
RUN mkdir /etc/vault
ONBUILD ADD config /etc/vault/config
RUN useradd  -r vault
RUN chown vault: -R /etc/vault/
ENV VERSION=0.5.0
RUN curl -sLo /opt/vault.zip https://releases.hashicorp.com/vault/${VERSION}/vault_${VERSION}_linux_amd64.zip  && \
    python3 -m zipfile -e /opt/vault.zip /usr/local/sbin && rm -f /opt/vault.zip
RUN chmod +x /usr/local/sbin/vault
USER vault
