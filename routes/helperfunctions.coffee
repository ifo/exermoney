#connection = require '../connection'
models = require '../models/workoutmodels'
user = models.User

module.exports = 
  authenticate: (username, password, callback) ->
    if password == process.env.PASSWORD
      callback true
      return
    callback false

  getuseridbyname: (name, callback) ->
    user.findOne {"name": name}, (err, usr) ->
      callback usr._id

