connection = require '../connection'

module.exports = 
  authenticate: (username, password) ->
    if password == connection.password
      return true
    return false
