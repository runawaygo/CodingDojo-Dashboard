require('mocha')
require('chai').should()

describe 'doUnitTest for CodingDojo project', ->
  doUnitTest = require('../doUnitTest')
  it 'Should return 2 successes testcases', (done)->
    doUnitTest 'master', (err, data)->
      data.should.to.be.a('object')
      data.testsuite.testcase.length.should.equal(3)
      done()
