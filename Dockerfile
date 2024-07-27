FROM ubuntu:latest

# Use baseimage-docker's init system.
#CMD ["/sbin/my_init"]

# Update package lists and install necessary dependencies
RUN apt-get update && \
    apt-get install -y ca-certificates curl wget gnupg && \
    apt-get clean

# Install additional packages
RUN apt-get update && \
    apt-get install -y iptables dnsutils lsb-release cron conntrack iproute2 python3-pip vim net-tools ssh && \
    apt-get clean

# Import the Beldex GPG key correctly
RUN wget https://deb.beldex.io/pub.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/beldex.gpg

# Add the Beldex repository
RUN echo "deb https://deb.beldex.io/apt-repo stable main" > /etc/apt/sources.list.d/beldex.list

# Update package lists and install Beldex master-node
RUN apt-get update && \
    apt-get install -y beldex-master-node && \
    apt-get clean

# Set the entrypoint to run the Beldex node service in the foreground
CMD ["/lib/systemd/systemd"]
