exec = require('child_process').exec
parseString = require('xml2js').parseString
module.exports = (branch, callback)->
  exec "make -C ../CodingDojo test-xunit BRANCH='#{branch}'", (error, stdout, stderr)->
    if error and not stdout
      callback error 
      return

    parseString stdout, (err, json)->
      if err
        callback err 
        return

      callback null, json
