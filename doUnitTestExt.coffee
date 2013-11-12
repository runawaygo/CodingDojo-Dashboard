exec = require('child_process').exec
path = require 'path'
parseString = require('xml2js').parseString
fs = require 'fs'
module.exports = (repo)->
  (branch, callback)->
    url = "./repos/#{repo}"
    exec "make -C #{url} test-xunit BRANCH='#{branch}'", (error, stdout, stderr)->
      console.log stdout
      console.log stderr
      if error
        console.log '--------',error    
        callback error 
        return

      file = path.join(url, 'xunit.xml')  
      fs.readFile file, {encoding:'utf8'}, (err, data)->

        if error
          console.log '*********',error    
          callback error 
          return
        
        parseString data, (err, json)->
          if err
            callback err 
            return
          callback null, json
