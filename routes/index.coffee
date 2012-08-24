
#
# * GET home page.
# 

# placeholder objects

models = require '../models/workoutmodels'

workout = models.Workout
workouttype = models.WorkoutType
goal = models.Goal
weight = models.Weight
unit = models.Unit

workouts = []
workouttypes = []
goals = []
weights = []

model = require '../models/workoutmodels'

module.exports =
  index: (req, res) ->
    res.render 'index',
      title: 'exermoney'
      workouts: workouts
      workouttypes: workouttypes
      goals: goals
      weight: weights[0]

  newWorkout: (req, res) ->
    res.render 'addworkout',
      title: 'new workout'
      workouttypes: workouttypes

  addWorkout: (req, res) ->
    workout = req.body.workout
    workout.id = workouts.length
    workouts.push workout
    res.redirect '/'

  newWorkoutType: (req, res) ->
    res.render 'addworkouttype',
      title: 'new workout type'

  addWorkoutType: (req, res) ->
    workouttype = req.body.workouttype
    workouttype.id = workouttypes.length
    workouttypes.push workouttype
    res.redirect '/'

  newGoal: (req, res) ->
    res.render 'addgoal',
      title: 'additional goal'

  addGoal: (req, res) ->
    goal = req.body.goal
    goal.id = goals.length
    goals.push goal
    res.redirect '/'

  addWeight: (req, res) ->
    currentWeight = req.body.weight
    currentWeight.time = new Date
    weights.push currentWeight
    res.redirect '/'

