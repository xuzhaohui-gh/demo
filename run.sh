
# 进入测试用例源码目录
# cd workspacei

# 删除上次生成的报告文件
rm -rf cypress/results
rm -rf cypress/videos

# 创建容器并执行测试用例
docker run -it -v $PWD:/test -w /test cypress3.8.3:latest;

# 将测试报告合成一个html入口
npx mochawesome-merge cypress/results/*.json > merge-report.json
npx mochawesome-report-generator merge-report.json

# 拷贝测试报告至jenkins流水线任务工作空间目录供查看报告
# cd ../../
scp -r /root/workspace/mochawesome-report/ /var/lib/jenkins/workspace/自动化测试/

# 必须，否则jenkins任务无法正常退出，会认为任务失败
exit 0;
