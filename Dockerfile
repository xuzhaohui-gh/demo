FROM docker.io/cypress/included:3.8.3

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

WORKDIR /test
RUN  npm install --save-dev mocha mochawesome mochawesome-merge mochawesome-report-generator

ENTRYPOINT ["cypress", "run"]
