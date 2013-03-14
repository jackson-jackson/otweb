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
    css: (-> global.css)
  )
)

app.get('/register', (req, res) ->
  res.render('register', 
    js: (-> global.js), 
    css: (-> global.css)
  )
)

app.get('/deposit', (req, res) ->
  res.render('deposit', 
    js: (-> global.js), 
    css: (-> global.css)
  )
)

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

app.listen(3000)
