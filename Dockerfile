FROM ubuntu:14.04

MAINTAINER Tim Schonberger "flyingtoaster0@gmail.com"

# Install java7
RUN apt-get install -y software-properties-common && add-apt-repository -y ppa:webupd8team/java && apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl

RUN \
  wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
  tar -xzvf android-sdk_r24.4.1-linux.tgz && \
  rm android-sdk_r24.4.1-linux.tgz && \
  mv android-sdk-linux /usr/local/android-sdk

# Install Android Tools
RUN \
  echo y | /usr/local/android-sdk/tools/android update sdk --filter platform-tools --no-ui --force -a && \
  echo y | /usr/local/android-sdk/tools/android update sdk --filter build-tools-22.0.1 --no-ui --force -a

# Install Android APIs
RUN \
  echo y | /usr/local/android-sdk/tools/android update sdk --filter android-23 --no-ui --force -a && \
  echo y | /usr/local/android-sdk/tools/android update sdk --filter android-22 --no-ui --force -a && \
  echo y | /usr/local/android-sdk/tools/android update sdk --filter android-21 --no-ui --force -a && \
  echo y | /usr/local/android-sdk/tools/android update sdk --filter extra-android-support --no-ui --force -a && \
  echo y | /usr/local/android-sdk/tools/android update sdk --filter extra-android-m2repository --no-ui --force -a

# Setup ANDROID_HOME
ENV ANDROID_HOME /usr/local/android-sdk