SocketController = require "controllers/socketcontroller"

class ShowImageController extends SocketController

	constructor:->
		super
		$('#info').text('Waiting for data...')

	initEventListener:->
		super

		#listener to showimgdata
		@socket.on 'showimgdata', (data) ->
			#get image
			img = $('#show-img').get 0
			message
			try
				# set data for image
				img.width = data.width;
				img.height = data.height;
				img.src = data.source;

				message = ''

			catch error
				console.log error
				message = 'error receiving image data...'


			$('#info').text(message)


module.exports = ShowImageController