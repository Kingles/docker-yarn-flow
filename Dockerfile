FROM mhart/alpine-node:7.7

MAINTAINER Fernando Montoya <montogeek@gmail.com>

ENV FLOW_VERSION=0.41.0
ENV YARN_VERSION=0.21.3

ADD https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v${YARN_VERSION}.tar.gz /opt/yarn.tar.gz
RUN cd /opt/ && tar xf yarn.tar.gz && mv dist yarn && rm yarn.tar.gz
ENV PATH $PATH:/opt/yarn/bin/

RUN apk add --update alpine-sdk perl \
    && rm -rf /var/cache/apk/* \
    && cd /tmp \
    && curl -SL https://github.com/flowtype/flow-bin/archive/v${FLOW_VERSION}.tar.gz -o /tmp/flow-bin-${FLOW_VERSION}.tgz \
    && tar -xvzf /tmp/flow-bin-${FLOW_VERSION}.tgz -C /tmp/ \
    && rm /tmp/flow-bin-${FLOW_VERSION}.tgz \
    && cd /tmp/flow-bin-${FLOW_VERSION} \
    && make build \
    && cp /tmp/flow-bin-${FLOW_VERSION}/flow-linux64-v${FLOW_VERSION}/flow /usr/local/bin

VOLUME /app
WORKDIR /app

CMD ["flow", "version"]