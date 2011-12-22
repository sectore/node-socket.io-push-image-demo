
###
Abstract class for all socket based view controllers
###
class SocketController

	constructor:->
		@initAndConnect()
		@initEventListener()

	initAndConnect:->
		#connect socket
		@socket = io.connect( 'http://' + window.location.hostname + ':8080');

	initEventListener:->
		@socket.on 'connect', ->
			console.log "connected"

		@socket.on 'disconnect', ->
			console.log 'disconnected'

module.exports = SocketController