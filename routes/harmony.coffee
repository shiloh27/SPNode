#Controllers

users = require '../DB/users'

#GET home page
exports.index = (req, res) ->
  res.render('index', { title: 'Home' })

#  GET about page
exports.about = (req, res) ->
  res.render('about', { title: 'About'}) 

# GET amazon page
exports.amazon = (req, res) ->
  res.render('amazon', {title: 'Amazon'})

# GET lastFM page
exports.lastFM = (req, res) ->
  res.render('lastFM', {title: 'LastFM'})

#GET search page
exports.search = (req, res) ->
  res.render('search', {title: 'Search'})

#GET session/new
exports.newSession = (req, res) ->
  #console.log("GET sessions/new")
  #console.log("req.session.flash is: " + req.session.flash)
  #console.log("req.query.redir is " + req.query.redir)
  res.render('sessions/new', {title: 'New', redirect: req.query.redir})

#POST session/new
exports.postSession = (req, res) ->
  users.authenticate(req.body.login, req.body.password, (err, user) ->
    if(user)
      req.session.user = user
      res.redirect(req.body.redirect || '/')
    else
      res.locals.flash = err
      res.render('sessions/new', {title: 'Try Again!', redirect: req.body.redirect})
  )

exports.showUser = (req, res) ->
  res.render('users/show', {title: 'Profile Page'})

exports.deleteSession = (req, res) ->
  req.session.destroy()
  res.redirect('/')

exports.newUser = (req, res) ->
  res.render('users/new', {title: 'New User'})

exports.postUser = (req, res) ->
  console.log(req.body.username)
  console.log(req.body.password)
  users.save req.body.username, req.body.password, (err) ->
    if(err)
      console.log(err)

  res.redirect('/')
