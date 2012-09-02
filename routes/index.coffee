
#
# * GET home page.
# 

# placeholder objects

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
      user.findOne {"name" : "Steve"}, (err, usr) ->
        res.render 'index',
          title: 'exermoney'
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
    newWorkout = req.body.workout
    newWorkout.number = parseFloat newWorkout.number
    new workout(newWorkout).save ->
      res.redirect '/'

  newWorkoutType: (req, res) ->
    unit.find {}, (err, unit) ->
      res.render 'addworkouttype',
        title: 'new workout type'
        units: unit

  addWorkoutType: (req, res) ->
    newWorkouttype = req.body.workouttype
    newWorkouttype.value = parseFloat newWorkouttype.value
    newWorkouttype.per = parseFloat newWorkouttype.per
    new workouttype(req.body.workouttype).save ->
      res.redirect '/'

  newGoal: (req, res) ->
    res.render 'addgoal',
      title: 'additional goal'

  addGoal: (req, res) ->
    newGoal = req.body.goal
    newGoal.value = parseFloat newGoal.value
    newGoal.weight = parseFloat newGoal.weight
    new goal(newGoal).save ->
      res.redirect '/'

  addWeight: (req, res) ->
    user.findOne {"name" : "Steve"}, (err, usr) ->
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
    res.render 'adduser'
      title: 'new user'

  addUser: (req, res) ->
    newUser = req.body.user
    newUser.balance = 0
    new user(newUser).save ->
      res.redirect '/'

