class Server

	jade = require 'jade'
	express = require 'express'
	stitch  = require 'stitch'
	socket_io = require 'socket.io'
	stylus = require 'stylus'

	constructor:->
		@initAndRun()

	initAndRun:->
		@packageFiles()
		@initApp()
		@initRoutes()
		@runApp()
		@initIO()


	initApp:->
		@app = express.createServer()

		@app.configure =>
			# views  and templates
			@app.set "views", __dirname + "/app/views"
			@app.register '.jade'
			@app.set 'view engine', 'jade'
			# css
			@app.use stylus.middleware { src: __dirname, dest: __dirname + '/public' }
			# static files
			@app.use express.static(__dirname + "/public")
			# stitched file
			@app.get "/application.js", @package.createServer()

	runApp:->
		@app.listen 8080, =>
			addr = @app.address()
			console.log 'app listening on http://' + addr.address + ':' + addr.port

	initRoutes:->
		@app.get '/', (req, resp) ->
			resp.render 'home'

		@app.get '/showimage', (req, resp) ->
			resp.render 'showimage'


	initIO:->
		@io = socket_io.listen @app
		@io.set 'log level', 1

		@io.sockets.on 'connection', (socket) ->
			socket.on 'onimgdata', (data) ->
				console.log 'img data received';
				socket.broadcast.emit 'showimgdata', data


	packageFiles:->
		@package = stitch.createPackage
			# Specify the paths you want Stitch to automatically bundle up
			paths: [ __dirname + "/app/" ]

			# Specify your base libraries
			dependencies: [
				__dirname + '/lib/jquery-1.7.1.min.js'
			]


# create server instance
server = new Server()