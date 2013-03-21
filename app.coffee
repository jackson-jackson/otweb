config = require('./config')
express = require('express')
path = require('path')
engines = require('consolidate')

app = express()
app.enable('trust proxy')
app.engine('html', require('mmm').__express)
app.set('view engine', 'html')
app.set('views', __dirname + '/views')
app.use(express.static(__dirname + '/public'))
app.use(require('connect-assets')(src: 'public'))
app.use(express.bodyParser())
app.use(express.cookieParser())
app.use(app.router)

app.get('/', (req, res) ->
  res.render('index', 
    js: (-> global.js), 
    css: (-> global.css),
    layout: "layout"
  )
)

### ADVANCED UTILITIES: ###

app.get('/issueasset', (req, res) ->
  res.render('issueasset', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/newasset', (req, res) ->
  res.render('newasset', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/register', (req, res) ->
  res.render('register', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

### THE USER WALLET: ###

app.get('/addasset', (req, res) ->
  res.render('addasset', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/changepw', (req, res) ->
  res.render('changepw', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/editacct', (req, res) ->
  res.render('editacct', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/editasset', (req, res) ->
  res.render('editasset', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/editnym', (req, res) ->
  res.render('editnym', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/editserver', (req, res) ->
  res.render('editserver', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/exportcert', (req, res) ->
  res.render('exportcert', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/exportnym', (req, res) ->
  res.render('exportnym', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/importcert', (req, res) ->
  res.render('importcert', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/importnym', (req, res) ->
  res.render('importnym', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/newnym', (req, res) ->
  res.render('newnym', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/showpurse', (req, res) ->
  res.render('showpurse', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.post('/register', (req, res) ->
  exec = require('child_process').exec

  exec("opentxs newnym --args \"name #{req.body.username}\"" , (err, out, stderr) ->
    res.write(out)
    res.end()
  )
)

### ASSET ACCOUNTS: ###

app.get('/deposit', (req, res) ->
  res.render('deposit', 
    js: (-> global.js),
    css: (-> global.css),
    layout:"depositlayout"
  )
)

app.get('/newacct', (req, res) ->
  res.render('newacct', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/redeem', (req, res) ->
  res.render('redeem', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

app.get('/transfer', (req, res) ->
  res.render('transfer', 
    js: (-> global.js), 
    css: (-> global.css),
    layout:"layout"
  )
)

### DEALING WITH OTHER USERS: ###


### is this needed anymore?
app.get('/issue/:amount', (req, res) ->
  exec = require('child_process').exec

  exec("opentxs writecheque --myacct issuer --args \"memo \\\"Here's some OT-Bitcoins.\\\" amount #{req.params.amount} validfor 2592000\"", (err, out, stderr) ->
    res.write(out)
    res.end()
  )
)

app.use((err, req, res, next) ->
  res.status(500)
  console.log(err)
  res.end()
)
###

app.listen(config.server.port)
