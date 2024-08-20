FROM ubuntu:24.04

# Set non-interactive frontend for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
# Install necessary packages and configure repositories
RUN apt-get update -y && \
    apt-get install -y \
    software-properties-common \
    && add-apt-repository universe && \
    apt-get update -y && \
    apt-get install -y \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    supervisor \
    git \
    gpg \
    wget \
    tzdata \
    lsof \ 
    && rm -rf /var/lib/apt/lists/*

# Install noVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC

# Set up the virtual framebuffer (Xvfb)
RUN mkdir -p /etc/supervisor/conf.d
COPY supervisor.conf /etc/supervisor/conf.d/supervisord.conf

# Copy your application files
# COPY your-app /opt/your-app
# WORKDIR /opt/your-app

# RUN apt-get install wget kgpg -y
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
RUN echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null
RUN rm -f packages.microsoft.gpg

RUN apt install apt-transport-https -y 
RUN apt update -y
RUN apt install code -y

# Expose the noVNC port
EXPOSE 8080

# Start Supervisor to run all necessary processes
CMD ["/usr/bin/supervisord"]
