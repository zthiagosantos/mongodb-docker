FROM mongo:latest
USER root
RUN apt-get update && apt-get install -y iputils-ping

