
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
http = require("http")
path = require("path")
mongoose = require("mongoose")
mongodbstore = require("connect-mongo")(express)
app = express()
app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser(process.env.COOKIE_SECRET)
  app.use express.session(
    secret: process.env.COOKIE_SECRET
    store: mongodbstore( 
      url: process.env.SESSION_CONNECTION
    )
  )
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  mongoose.connect process.env.MONGOOSE_CONNECTION
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

app.configure "production", ->
  mongoose.connect process.env.MONGOOSE_CONNECTION
  app.use express.errorHandler()

loginRequired = (req, res, next) ->
  if req.session.authenticated
    next()
  else
    res.redirect('/session/new?redirect='+ req.url)

app.get "/", loginRequired, routes.index

app.get '/workout/new', loginRequired, routes.newWorkout
app.post '/workout/new', loginRequired, routes.addWorkout

app.get '/workouttype/new', loginRequired, routes.newWorkoutType
app.post '/workouttype/new', loginRequired, routes.addWorkoutType

app.get '/goal/new', loginRequired, routes.newGoal
app.post '/goal/new', loginRequired, routes.addGoal

app.post '/weight/new', loginRequired, routes.addWeight

app.get '/unit/new', loginRequired, routes.newUnit
app.post '/unit/new', loginRequired, routes.addUnit

app.get '/user/new', loginRequired, routes.newUser
app.post '/user/new', loginRequired, routes.addUser

app.get '/session/new', routes.newSession
app.post '/session/new', routes.addSession

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

