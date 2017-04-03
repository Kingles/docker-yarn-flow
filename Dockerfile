FROM node:7-slim

MAINTAINER Fernando Montoya <montogeek@gmail.com>

ENV FLOW_VERSION=0.42.0

RUN apt-get update -qq && apt-get -y install ocaml -qy libelf1 libelf-dev
RUN yarn global add flow-bin@${FLOW_VERSION}
RUN flow version