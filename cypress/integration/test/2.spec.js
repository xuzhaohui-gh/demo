describe('我的第二个测试', function() {
  it('失败的测试用例：', function() {
    cy.visit('https://e.vip.com')
    cy.get('.login-btn1234').first().click()
  })
})
