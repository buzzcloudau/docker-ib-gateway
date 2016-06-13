FROM java:8
MAINTAINER clifton <cliftonk@gmail.com>

# install xvfb and other X dependencies for IB
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get update -y \
    && apt-get install -y xvfb libxrender1 libxtst6 x11vnc socat \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN mkdir /ib-gateway
WORKDIR /ib-gateway

# download and install the IB-gateway
RUN  wget -O jts4launch.jar -q http://127.0.0.1/jars/jts4launch.jar \
 && wget -O log4j-1.2.17.jar -q http://127.0.0.1/jars/log4j-1.2.17.jar \
 && wget -O total.jar -q http://127.0.0.1/jars/total.jar \
 && wget -O twslaunch-install4j-1.5.jar -q https://127.0.0.1/jars/twslaunch-install4j-1.5.jar \
 && wget -O twslaunch.jar -q http://127.0.0.1/jars/twslaunch.jar

# install init scripts and binaries
ADD config/jts.ini /ib-gateway/jts.ini
ADD init/xvfb_init /etc/init.d/xvfb
ADD init/vnc_init /etc/init.d/vnc
ADD bin/xvfb-daemon-run /usr/bin/xvfb-daemon-run
ADD bin/run-gateway /usr/bin/run-gateway

# vnc (optional)
# set your own password to launch vnc
# ENV VNC_PASSWORD doughnuts

# 5900 for VNC, 4003 for the gateway API via socat
EXPOSE 5900 4003
VOLUME /ib-gateway

ENV DISPLAY :0

CMD ["/usr/bin/run-gateway"]
