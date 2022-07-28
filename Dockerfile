FROM ubuntu:20.04

WORKDIR /source

# Envs
ENV DEBIAN_FRONTEND="noninteractive"
ENV INSTALLATION_OPTIONS="0"
ENV CURRENT_USER="username"

# Copy contents
COPY ./replaces/FirebirdConnection.php /source/replaces/FirebirdConnection.php
COPY ./entrypoint.sh /entrypoint.sh

# Install packages
RUN apt update
RUN apt install -y \
    zip \
    wget \
    expect

# Setup Application
RUN wget https://github.com/dreamfactorysoftware/dreamfactory/raw/master/installers/dfsetup.run
RUN chmod +x ./dfsetup.run
RUN ./dfsetup.run --accept --nox11

WORKDIR /opt/dreamfactory

# Application dependencies and configuration
RUN composer i

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Start
ENTRYPOINT ["/entrypoint.sh"]
