
#
# * GET home page.
# 
hf = require './helperfunctions'

models = require '../models/workoutmodels'

unit = models.Unit
workouttype = models.WorkoutType
workout = models.Workout
workouttarget = models.WorkoutTarget
goal = models.Goal
weight = models.Weight
expense = models.Expense
user = models.User

module.exports =
  index: (req, res) ->
    unit.find {}, (err, unit) ->
      user.findById req.session.uid, (err, usr) ->
        res.render 'index',
          title: 'exermoney'
          balance: usr.balance
          workouts: usr.workouts
          workouttypes: usr.workouttypes
          goals: usr.goals
          weights: usr.weights[usr.weights.length - 1]
          units: unit
          user: usr

  newWorkout: (req, res) ->
    workouttype.find {}, (err, workouttype) ->
      res.render 'addworkout',
        title: 'new workout'
        workouttypes: workouttype

  addWorkout: (req, res) ->
    user.findById req.session.uid, (err, usr) ->
      newWorkout = req.body.workout
      newWorkout.number = parseFloat newWorkout.number
      usr.workouts.push(newWorkout)
      usr.save ->
        res.redirect '/'

  newWorkoutType: (req, res) ->
    unit.find {}, (err, unit) ->
      res.render 'addworkouttype',
        title: 'new workout type'
        units: unit

  addWorkoutType: (req, res) ->
    user.findById req.session.uid, (err, usr) ->
      newWorkouttype = req.body.workouttype
      newWorkouttype.value = parseFloat newWorkouttype.value
      newWorkouttype.per = parseFloat newWorkouttype.per
      usr.workouttypes.push(newWorkouttype)
      usr.save ->
        res.redirect '/'

  newGoal: (req, res) ->
    res.render 'addgoal',
      title: 'additional goal'

  addGoal: (req, res) ->
    user.findById req.session.uid, (err, usr) ->
      newGoal = req.body.goal
      newGoal.value = parseFloat newGoal.value
      newGoal.weight = parseFloat newGoal.weight
      if usr.goals && usr.goals.length
        usr.goals.push(newGoal)
      else
        usr.goals = [newGoal]
      usr.save ->
        res.redirect '/'

  addWeight: (req, res) ->
    user.findById req.session.uid, (err, usr) ->
      newWeight = new weight
      newWeight.weight = parseFloat req.body.weight
      if usr.weights && usr.weights.length
        usr.weights.push(newWeight)
      else
        usr.weights = [newWeight]
      usr.save ->
        res.redirect '/'

  newUnit: (req, res) ->
    res.render 'addunit'
      title: 'new workout unit'

  addUnit: (req, res) ->
    new unit(req.body.unit).save ->
      res.redirect '/'

  newUser: (req, res) ->
    res.render 'register'
      title: 'register'

  addUser: (req, res) ->
    newUser = req.body.user
    newUser.balance = 0
    new user(newUser).save ->
      res.redirect '/'

  newSession: (req, res) ->
    res.render 'login'
      title: 'login'
      redirect: req.query.redirect or req.redirect
  
  addSession: (req, res) ->
    hf.authenticate req.body.username, req.body.password, (authenticated) ->
      hf.getuseridbyname req.body.username, (uid) ->
        if authenticated
          req.session.authenticated = true
          req.session.uid = uid
          res.redirect '/'
        else
          res.redirect '/session/new'

