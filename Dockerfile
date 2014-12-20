FROM phusion/baseimage:0.9.11
MAINTAINER needo <needo@superhero.org>
ENV DEBIAN_FRONTEND noninteractive
# Set correct environment variables
ENV HOME /root
# Use baseimage-docker's init system
CMD ["/sbin/my_init"]
# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody
RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse"
RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse"
RUN apt-get update -q
# Install Dependencies
RUN apt-get install -qy python ca-certificates wget unrar git
# Install Moviegrabber
RUN git clone https://github.com/binhex/moviegrabber.git /opt/moviegrabber
RUN chown -R nobody:users /opt/moviegrabber
EXPOSE 9191
# Moviegrabber Configuration
VOLUME /config
# Downloads/Movies directory
RUN mkdir /mnt/XBMC-Media /mnt/Downloads
# Add Moviegrabber to runit
RUN mkdir /etc/service/moviegrabber
ADD moviegrabber.sh /etc/service/moviegrabber/run
RUN chmod +x /etc/service/moviegrabber/run
