FROM docker.io/cypress/included:3.8.3

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

# WORKDIR /e2e
# RUN  npm install --save-dev @babel/core @babel/preset-env @cypress/webpack-preprocessor babel-loader webpack lodash dayjs  mocha mochawesome mochawesome-merge mochawesome-report-generator

ENTRYPOINT ["cypress", "run"]