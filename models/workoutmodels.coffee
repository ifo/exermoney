mongoose = require 'mongoose'

# Global list -> will likely replace with built in table
Unit = new mongoose.Schema(
  name: String
)

# Subdoc of: User
WorkoutType = new mongoose.Schema(
  name: String
  value: Number
  per: Number
  unit: mongoose.Schema.Types.ObjectId
)

# Subdoc of: User
Workout = new mongoose.Schema(
  description: String
  number: Number
  type: mongoose.Schema.Types.ObjectId
  date: 
    type: Date, default: Date.now
)

WorkoutTarget = new mongoose.Schema(
  description: String
  timesperweek: Number
  unitspertime: Number
  workouttype: mongoose.Schema.Types.ObjectId
  startdate:
    type: Date, default: Date.now
  enddate:
    type: Date, required: false
)

# Subdoc of: User
Goal = new mongoose.Schema(
  name: String
  value: Number
  weight: 
    type: Number, required: false
)

# Subdoc of: User
Weight = new mongoose.Schema(
  weight: Number
  date: 
    type: Date, default: Date.now
)

# Subdoc of: User
Expense = new mongoose.Schema(
  description: String
  cost: Number
)

User = new mongoose.Schema(
  name: String
  weights: [Weight]
  workouttypes: [WorkoutType]
  workouts: [Workout]
  expenses: [Expense]
  balance: Number
  goals: [Goal]
  workouttargets: [WorkoutTarget]
  created:
    type: Date, default: Date.now
)

module.exports = 
  Unit: mongoose.model 'Unit', Unit
  WorkoutType: mongoose.model 'WorkoutType', WorkoutType
  Workout: mongoose.model 'Workout', Workout
  WorkoutTarget: mongoose.model 'WorkoutTarget', WorkoutTarget
  Goal: mongoose.model 'Goal', Goal
  Weight: mongoose.model 'Weight', Weight
  Expense: mongoose.model 'Expense', Expense
  User: mongoose.model 'User', User
