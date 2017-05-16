FROM gone/base
LABEL MAINTAINER="Matthew Baggett <matthew@baggett.me>"
RUN mkdir /scripts && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends \
        iptables \
        openvpn procps \
        python \
        python-pip \
        python-setuptools \
        python-qrtools \
        screen && \
    echo '#!/usr/bin/env bash' >/sbin/resolvconf && \
    echo 'conf=/etc/resolv.conf' >>/sbin/resolvconf && \
    echo '[[ -e $conf.orig ]] || cp -p $conf $conf.orig' >>/sbin/resolvconf && \
    echo 'if [[ "${1:-""}" == "-a" ]]; then' >>/sbin/resolvconf && \
    echo '    cat >${conf}' >>/sbin/resolvconf && \
    echo 'elif [[ "${1:-""}" == "-d" ]]; then' >>/sbin/resolvconf && \
    echo '    cat $conf.orig >$conf' >>/sbin/resolvconf && \
    echo 'fi' >>/sbin/resolvconf && \
    chmod +x /sbin/resolvconf && \
    addgroup --system vpn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* && \
    pip install wheel
VOLUME ["/vpn"]

ENV VPN_CONFIG=default
ENV VPN_USERNAME=YouShouldReadTheDocs
ENV VPN_PASSWORD=""

COPY login.sh screen-starter.sh 2fa-key-gen.py requirements.txt /scripts/
WORKDIR /scripts
RUN pip install -r requirements.txt

RUN mkdir /etc/service/screen && \
    #mkdir /etc/service/monitor && \
    mkdir /etc/service/openvpn
COPY docker/run.screen.sh /etc/service/screen/run
COPY docker/run.openvpn.sh /etc/service/openvpn/run
#COPY docker/run.monitor.sh /etc/service/monitor/run
RUN chmod +x /etc/service/*/run