FROM debian:wheezy 

# Install packages required to add users and install Nix
RUN apt-get update && apt-get install -y curl bzip2 adduser

# Add the user app for security reasons and for Nix
RUN adduser --disabled-password --gecos '' app 

# Nix requires ownership of /nix.
RUN mkdir -m 0755 /nix && chown app /nix

# Change docker user to app
USER app

# Set some environment variables for Docker and Nix
ENV USER app

# Change our working directory to $HOME
WORKDIR /home/app

# install Nix
RUN curl https://nixos.org/nix/install | sh

# update the nix channels
# Note: nix.sh sets some environment variables. Unfortunately in Docker
# environment variables don't persist across `RUN` commands
# without using Docker's own `ENV` command, so we need to prefix
# our nix commands with `. .nix-profile/etc/profile.d/nix.sh` to ensure
# nix manages our $PATH appropriately.
RUN . .nix-profile/etc/profile.d/nix.sh && nix-channel --update


# Copy our nix expression into the container
#COPY default.nix /home/app/

# run nix-build to pull the 
RUN . .nix-profile/etc/profile.d/nix.sh && nix-env -iA nixpkgs.clojure

RUN clojure

# run our application
CMD ["./results/bin/run"]