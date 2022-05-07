FROM debian:stable
WORKDIR /root



RUN \
  echo "*** install package ***" && \
  DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y apt-utils && apt-get upgrade -y 
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get -y install --fix-missing \
    dnsutils \
    vim \
    wget \
    less \
    telnet \ 
    dialog \
    zip \
    unzip \
    openresolv \
    transmission-daemon \
    locales \
    curl \
    wireguard \
    cron \
    procps \
    file \
    iproute2 \
    iputils-ping \
    iptables \
    tmux && \
  echo " *** configure transmission *** " && \
  sed -i 's/USER=debian-transmission/USER=root/g' /etc/init.d/transmission-daemon 
#ENV LANG en_US.UTF-8
#ENV LC_CTYPE en_US.UTF-8
RUN \ 
#  echo " *** set timezone ***" && \
#  rm /etc/localtime && ln -s /usr/share/zoneinfo/EST5EDT /etc/localtime && \
  echo " *** set locales ***" && \
  rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && localedef -i en_US -f UTF-8 en_US.UTF-8 && \
  echo 'LANG=en_US.UTF-8; export LANG' >> /etc/profile  && \
  echo "**** cleanup ****" && \
  apt-get autoremove -y && \
  apt-get clean -y && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /etc/cron.d/anacron \
    /etc/cron.daily/0anacron

COPY ./build/startup.sh /usr/bin/startup.sh

ENTRYPOINT "/usr/bin/startup.sh"

# ports and volumes
EXPOSE 9091
