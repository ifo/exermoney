
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
    weight.find {}, (err, weight) ->
      goal.find {}, (err, goal) ->
        res.render 'index',
          title: 'exermoney'
          workouts: workouts
          workouttypes: workouttypes
          goals: goal
          weights: weight[weight.length-1]

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
    ###
    goal = req.body.goal
    goal.id = goals.length
    goals.push goal
    ###
    newGoal = req.body.goal
    newGoal.value = parseFloat(newGoal.value)
    newGoal.weight = parseFloat(newGoal.weight)
    new goal(newGoal).save ->
      res.redirect '/'

  addWeight: (req, res) ->
    
    newWeight = 
      "weight": parseFloat(req.body.weight)
      "date": new Date()
    ###
    #req.body.weight.time = new Date
    addWeight[weight] = parseFloat(req.body.weight)
    addWeight[date] = new Date()
    ###
    new weight(newWeight).save ->
      res.redirect '/'

###
  addWeight: (req, res) ->
    currentWeight = req.body.weight
    currentWeight.time = new Date
    weights.push currentWeight
    res.redirect '/'
###

