FROM ubuntu:16.04
MAINTAINER zembi4 <zembi4087@gmail.com
ENV DEBIAN_FRONTEND noninteractive

# Install s6-overlay
ENV s6_overlay_version="1.17.1.1"
ADD https://github.com/just-containers/s6-overlay/releases/download/v${s6_overlay_version}/s6-overlay-amd64.tar.gz /tmp/
RUN tar zxf /tmp/s6-overlay-amd64.tar.gz -C / && $_clean
ENV S6_LOGGING="1"

# Install samba
RUN \
	apt-get update && \
	apt-get install --no-install-recommends -y samba && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Create samba user as user 'nobody'
#RUN useradd smbuser -o -u 65534 -M


# Default container settings
VOLUME ["/etc/samba"]
VOLUME ["/mnt/share"]

# Expose Samba ports
EXPOSE 137 138 139 445

# Run Samba in the foreground
CMD ["/usr/sbin/smbd", "-FS"]
