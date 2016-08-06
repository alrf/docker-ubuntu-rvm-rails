FROM ubuntu:latest

LABEL description="RVM-RAILS"

USER root

# Update 
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl sudo -y

# Setup environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV RUBY_VERSION 2.3.0

# Install RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | sudo bash -s stable
RUN /bin/bash -l -c 'source /etc/profile'

# Install Ruby
RUN /bin/bash -l -c 'rvm install $RUBY_VERSION'
RUN /bin/bash -l -c 'rvm use $RUBY_VERSION --default'
RUN /bin/bash -l -c 'rvm rubygems current'

# Install bundler
RUN /bin/bash -l -c 'gem install bundler --no-doc --no-ri'

# Install Rails
RUN \curl -sSL https://get.rvm.io | sudo bash -s stable --rails

# Minimise of the image
RUN /bin/bash -l -c 'rm -rf /usr/local/rvm/archives/*'
