exec = require('child_process').exec
parseString = require('xml2js').parseString
fs = require('fs')

module.exports = (branch, callback)->
  exec "make -C ../CodingDojo-Java test-branch BRANCH='#{branch}'", (error, stdout, stderr)->
    if error and not stdout
      callback error 
      return
    data = fs.readFileSync('../CodingDojo-Java/target/surefire-reports/TEST-com.mycompany.app.AppTest.xml', 'utf8')
    parseString data, (err, json)->
      if err
        console.log stdout
        console.log err
        callback err 
        return
        
      callback null, json
