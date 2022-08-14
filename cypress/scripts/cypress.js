// 引入cypress、mochawesome-merge(集成测试报告)、mochawesome-report-generator(生成一个html文件)插件
const cypress = require('cypress')
const { merge } = require('mochawesome-merge')
const generator = require('mochawesome-report-generator')


// 执行cypress并生成测试报告，合并测试报告，把测试报告生成html文件，退出进程
async function runTest() {
    const { totalFailed } = await cypress.run()
    console.log('run success')
    const jsonReport = await merge()
    console.log(jsonReport)
    await generator.create(jsonReport)
    process.exit(totalFailed)
}

// 执行函数，终端执行：node cypress\scripts\cypress.js(node 执行文件的相对路径)
runTest()