express = require('express')
path = require('path')
engines = require('consolidate')

RedisStore = require('connect-redis')(express)
sessionStore = new RedisStore(ttl: 172800)

app = express()
app.enable('trust proxy')
app.engine('html', require('mmm').__express)
app.set('view engine', 'html')
app.set('views', __dirname + '/views')
app.use(express.static(__dirname + '/public'))
app.use(require('connect-assets')(src: 'public'))
app.use(express.bodyParser())
app.use(express.cookieParser())
app.use(express.session(secret: 'weareallmadeofstars', store: sessionStore, key: 'otweb.sid'))
app.use(app.router)

app.get('/', (req, res) ->
  res.render('index', 
    js: (-> global.js), 
    css: (-> global.css),
    layout: "layout"
  )
)

### Create New Nym and Register on Vanbtc.ca ###

app.get('/register', (req, res) ->
  res.render('register', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/shownyms', (req, res) ->
  exec = require('child_process').exec

  exec("opentxs shownyms | sed '1,3d'", (err, out, stderr) ->
    lines = out.split('\n')
    lines.pop()
    results = lines.map (line) ->
      regex = /(.*) --- (.*)/
      match = regex.exec(line)
      if match
        {"nym": match[1], "label": match[2]}
    res.write(JSON.stringify(results))
    res.end()
  )
)

app.get('/showassets', (req, res) ->
  exec = require('child_process').exec

  exec("opentxs showassets | sed '1,3d'", (err, out, stderr) ->
    lines = out.split('\n')
    lines.pop()
    results = lines.map (line) ->
      regex = /(.*) --- (.*)/
      match = regex.exec(line)
      if match
        {"asset": match[1], "name": match[2]}
    res.write(JSON.stringify(results))
    res.end()
  )
)

app.post('/register', (req, res) ->
  exec = require('child_process').exec

  exec("echo #{req.body.password} | opentxs newnym --args \"name #{req.body.username}\" && opentxs register --mynym #{req.body.username} --server vancouver" , (err, out, stderr) ->
      res.redirect('/newacct')
  )
)

### Create Account ###

app.get('/newacct', (req, res) ->
  res.render('newacct', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

### app.post('/newacct', (req, res) ->
  exec = require('child_process').exec

exec("opentxs newacct --mynym #{req.body.mynym} --mypurse #{req.body.mypurse} --server vancouver" , (err, out, stderr) -> 
    exec("opentxs newacct --mynym #{req.body.mynym} --mypurse #{req.body.mypurse} --server vancouver" , (err, out, stderr) ->
    res.redirect('/transfer')
  )
)
###

### Transfer Funds ###

app.get('/transfer', (req, res) ->
  res.render('transfer', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.post('/transfer', (req, res) ->
  exec = require('child_process').exec

  exec("echo btc | opentxs transfer --myacct #{req.body.myacct} --hisacct #{req.body.hisacct} --args \"amount #{req.body.amount}\"" , (err, out, stderr) ->
    res.redirect('/register')
  )
)

app.listen(3000)
