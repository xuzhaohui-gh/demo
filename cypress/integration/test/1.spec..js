describe('我的第一个测试', function() {
  it('百度测试用例：', function() {
    cy.visit('https://e.vip.com')
    cy.get('.login-btn').first().click()
  })
})