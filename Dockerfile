FROM debian:bullseye-slim

MAINTAINER Vyacheslav Andreykiv <https://github.com/vandreykiv>

ENV DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-get update && apt-get install -y redsocks iptables && rm -rf /var/lib/apt/lists/*

# Copy configuration files...
COPY redsocks.tmpl /etc/redsocks.tmpl
COPY redsocks.sh /usr/local/bin/redsocks.sh
COPY redsocks-fw.sh /usr/local/bin/redsocks-fw.sh

RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/redsocks.sh"]