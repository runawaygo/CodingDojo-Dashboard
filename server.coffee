connect = require "connect"
fs = require 'fs'
async = require 'async'
doUnitTest = require './doUnitTest'

connect()
  .use('/', connect.static(__dirname+"/app"))
  .use('/results', (req,res)->
    branchList = ['master', 'play1']
    async.mapSeries branchList, doUnitTest, (err, data)->
      console.log 'superwolf'
      console.log data
      console.log err
      for item, index in data
        item.branchName = branchList[index]
      res.end JSON.stringify data

  )
  .use('/mock_results', (req,res)->
    testData = '''[{"testsuite":{"$":{"name":"Mocha Tests","tests":"3","failures":"1","errors":"1","skipped":"0","timestamp":"Thu, 03 Oct 2013 08:22:23 GMT","time":"0.007"},"testcase":[{"$":{"classname":"test abc","name":"abc return value type should be a string","time":"0.001"}},{"$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"0"}},{"$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"NaN","message":"expected 'hello dojo' to equal 'hello dojo1'"},"failure":[{"_":"AssertionError: expected 'hello dojo' to equal 'hello dojo1'","$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"NaN","message":"expected 'hello dojo' to equal 'hello dojo1'"}}]}]},"branchName":"master"},{"testsuite":{"$":{"name":"Mocha Tests","tests":"3","failures":"1","errors":"1","skipped":"0","timestamp":"Thu, 03 Oct 2013 08:22:23 GMT","time":"0.007"},"testcase":[{"$":{"classname":"test abc","name":"abc return value type should be a string","time":"0.001"}},{"$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"0"}},{"$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"NaN","message":"expected 'hello dojo' to equal 'hello dojo1'"},"failure":[{"_":"AssertionError: expected 'hello dojo' to equal 'hello dojo1'","$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"NaN","message":"expected 'hello dojo' to equal 'hello dojo1'"}}]}]},"branchName":"master"},{"testsuite":{"$":{"name":"Mocha Tests","tests":"3","failures":"1","errors":"1","skipped":"0","timestamp":"Thu, 03 Oct 2013 08:22:23 GMT","time":"0.007"},"testcase":[{"$":{"classname":"test abc","name":"abc return value type should be a string","time":"0.001"}},{"$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"0"}},{"$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"NaN","message":"expected 'hello dojo' to equal 'hello dojo1'"},"failure":[{"_":"AssertionError: expected 'hello dojo' to equal 'hello dojo1'","$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"NaN","message":"expected 'hello dojo' to equal 'hello dojo1'"}}]}]},"branchName":"master"}]'''
    res.end testData      
  )
  .listen(9000)