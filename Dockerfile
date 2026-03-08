FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        python3 python3-pip python3-psutil \
        gcc libc6-dev make \
        sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PIP_BREAK_SYSTEM_PACKAGES=1

# UserID 5000 required for Artemis Build Infrastructure
RUN useradd -m --uid 5000 artemis_user && \
    echo "artemis_user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# Change the user to the default Artemis user (away from root)
USER artemis_user
