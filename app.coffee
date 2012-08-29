
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
http = require("http")
path = require("path")
mongoose = require("mongoose")
#connection.coffee file containing connection string information
connection = require("./connection")
app = express()
app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  mongoose.connect connection.development
  app.use express.errorHandler()

app.configure "production", ->
  mongoose.connect connection.production
  app.use express.errorHandler()

app.get "/", routes.index

app.get '/workout/new', routes.newWorkout
app.post '/workout/new', routes.addWorkout

app.get '/workouttype/new', routes.newWorkoutType
app.post '/workouttype/new', routes.addWorkoutType

app.get '/goal/new', routes.newGoal
app.post '/goal/new', routes.addGoal

app.post '/weight/new', routes.addWeight

app.get '/unit/new', routes.newUnit
app.post '/unit/new', routes.addUnit

app.get '/user/new', routes.newUser
app.post '/user/new', routes.addUser


http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

