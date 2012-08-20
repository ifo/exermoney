
#
# * GET home page.
# 

# placeholder objects
workouts = []
workouttypes= []
goals = []
weight = []


module.exports =
  index: (req, res) ->
    res.render 'index',
      title: 'exermoney'
      workouts: workouts
      workouttypes: workouttypes
      goals: goals
      weight: weight

  newWorkout: (req, res) ->
    res.render 'addworkout',
      title: 'new workout'

  addWorkout: (req, res) ->
    workout.name = req.body.workout
    workout.id = workouts.length
    workout.type = req.body.workouttype
    workout.time = req.body.workouttime
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
    goal = res.body.goal
    goal.weight = res.body.weight
    goals.push goal
    res.redirect '/'

  addWeight: (req, res) ->
    currentWeight = res.body.weight
    weight.push currentWeight
    res.redirect '/'

