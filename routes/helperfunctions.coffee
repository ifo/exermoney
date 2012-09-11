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

  # replaced by mongoose subdoc get by id:
  # subdocbyid = doc.subdoc.id(id) - where id is a string of the hex id
  ###
  getworkouttype: (workouttypeid, workouttypes, callback) ->
    i = 0
    while i < workouttypes.length
      if workouttypes[i]._id is mongoose.Types.ObjectId(workouttypeid)
        callback workouttypes[i]
        return
      i++
    
    workouttype = 
      (wt for wt in workouttypes when workouttypes._id is workouttypeid)
    callback workouttype[0]
    
  ###
  ###
  getworkouttype: (workouttypeid, workouttypes) ->
    i = 0
    while i < workouttypes.length
      if workouttypes[i]._id is mongoose.Types.ObjectId(workouttypeid)
        return workouttypes[i]
      i++
  ###
  getworkouttype: (workouttypeid) ->
    workouttype.findById workouttypeid, (err, wotype) ->
      return wotype
