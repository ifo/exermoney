
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
http = require("http")
path = require("path")
mongoose = require("mongoose")
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
  mongoose.connect 'mongodb://localhost/exermoney-dev'
  app.use express.errorHandler()

app.get "/", routes.index

app.get '/workout/new', routes.newWorkout
app.post '/workout/new', routes.addWorkout

app.get '/workouttype/new', routes.newWorkoutType
app.post '/workouttype/new', routes.addWorkoutType

app.get '/goal/new', routes.newGoal
app.post '/goal/new', routes.addGoal

app.post '/weight/new', routes.addWeight


http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

