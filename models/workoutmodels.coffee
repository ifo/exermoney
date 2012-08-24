mongoose = require 'mongoose'

Unit = new mongoose.Schema(
  name: String
)

WorkoutType = new mongoose.Schema(
  name: String
  value: Number
  #unit: ObjectId
)

Workout = new mongoose.Schema(
  description: String
  number: Number
  #type: ObjectId
  date: Date
)

Goal = new mongoose.Schema(
  name: String
  value: Number
  weight: Number
)

Weight = new mongoose.Schema(
  weight: Number
  date: Date
)

module.exports = 
  Unit: mongoose.model 'Unit', Unit
  WorkoutType: mongoose.model 'WorkoutType', WorkoutType
  Workout: mongoose.model 'Workout', Workout
  Goal: mongoose.model 'Goal', Goal
  Weight: mongoose.model 'Weight', Weight

#module.exports = mongoose.model 'WorkoutType', WorkoutType
#module.exports = mongoose.model 'Workout', Workout
#module.exports = mongoose.model 'Goal', Goal
#module.exports = mongoose.model 'Weight', Weight
