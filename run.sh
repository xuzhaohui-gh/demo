rm -r cypress/mochawesome-report
docker run -it -v $PWD:/test -w /test cypress3.8.3:latest