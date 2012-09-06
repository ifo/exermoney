#connection = require '../connection'
models = require '../models/workoutmodels'
user = models.User

module.exports = 
  authenticate: (username, password, callback) ->
    if password == process.env.PASSWORD
      callback true
      return
    callback false

  updatebalance: (userid, value, number, callback) ->
    user.findById userid, (err, usr) ->
      usr.balance = usr.balance + value * number
      callback true

  getuseridbyname: (name, callback) ->
    user.findOne {"name": name}, (err, usr) ->
      callback usr._id
