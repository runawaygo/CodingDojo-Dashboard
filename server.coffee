connect = require "connect"
fs = require 'fs'
async = require 'async'
exec = require('child_process').exec
doUnitTest_java = require './doUnitTest.java'
doUnitTestExt = require './doUnitTestExt'
doUnitTest = require './doUnitTest'
path = require 'path'

connect()
  .use('/', connect.static(__dirname+"/app"))
  .use(connect.query())
  .use('/results', (req, res)->
    repo = req.query.repo 
    fs.exists path.join(__dirname,'repos',repo), (exists)->
      if exists
        exec "git --git-dir='./repos/#{repo}/.git' fetch", (error, stdout, stderr)->
          branchList = req.query.branches.split(',')
          branchFunc = doUnitTestExt(repo)
          async.mapSeries branchList, branchFunc, (err, data)->
            for item, index in data
              if not item
                delete data[index]
                continue
              item.branchName = branchList[index]

            res.end JSON.stringify data    
      else
        res.end "No the repo name:#{repo}"
  )
  .use('/java/results', (req,res)->
    exec "git --git-dir='../CodingDojo/.git' fetch", (error, stdout, stderr)->
      branchList = ['master']
      async.mapSeries branchList, doUnitTest_java, (err, data)->
        for item, index in data
          if not item
            delete data[index]
            continue
          item.branchName = branchList[index]

        res.end JSON.stringify data

  )
  .use('/mock_results', (req,res)->
    testData = '''[{"testsuite":{"$":{"name":"Mocha Tests","tests":"3","failures":"0","errors":"1","skipped":"0","timestamp":"Thu, 03 Oct 2013 08:22:23 GMT","time":"0.007"},"testcase":[{"$":{"classname":"test abc","name":"abc return value type should be a string","time":"0.001"}},{"$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"0"}},{"$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"NaN","message":"expected 'hello dojo' to equal 'hello dojo1'"},"failure":[{"_":"AssertionError: expected 'hello dojo' to equal 'hello dojo1'","$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"NaN","message":"expected 'hello dojo' to equal 'hello dojo1'"}}]}]},"branchName":"master"},{"testsuite":{"$":{"name":"Mocha Tests","tests":"3","failures":"1","errors":"1","skipped":"0","timestamp":"Thu, 03 Oct 2013 08:22:23 GMT","time":"0.007"},"testcase":[{"$":{"classname":"test abc","name":"abc return value type should be a string","time":"0.001"}},{"$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"0"}},{"$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"NaN","message":"expected 'hello dojo' to equal 'hello dojo1'"},"failure":[{"_":"AssertionError: expected 'hello dojo' to equal 'hello dojo1'","$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"NaN","message":"expected 'hello dojo' to equal 'hello dojo1'"}}]}]},"branchName":"master"},{"testsuite":{"$":{"name":"Mocha Tests","tests":"3","failures":"1","errors":"1","skipped":"0","timestamp":"Thu, 03 Oct 2013 08:22:23 GMT","time":"0.007"},"testcase":[{"$":{"classname":"test abc","name":"abc return value type should be a string","time":"0.001"}},{"$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"0"}},{"$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"NaN","message":"expected 'hello dojo' to equal 'hello dojo1'"},"failure":[{"_":"AssertionError: expected 'hello dojo' to equal 'hello dojo1'","$":{"classname":"test abc","name":"abc return value type should be 'hello dojo'","time":"NaN","message":"expected 'hello dojo' to equal 'hello dojo1'"}}]}]},"branchName":"master"}]'''
    res.end testData      
  )
  .listen(9000)