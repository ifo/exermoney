
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
    weight.find {}, (err, weight) ->
      goal.find {}, (err, goal) ->
        unit.find {}, (err, unit) ->
          workouttype.find {}, (err, workouttype) ->
            workout.find {}, (err, workout) ->
              res.render 'index',
                title: 'exermoney'
                workouts: workout
                workouttypes: workouttype
                goals: goal
                weights: weight[weight.length-1]
                units: unit

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
    newWeight = {}
    newWeight.weight = parseFloat req.body.weight
    new weight(newWeight).save ->
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

