SocketController = require "controllers/socketcontroller"

class HomeController extends SocketController

	constructor:->
		super


	initEventListener:->
		super

		$(".my-image").click (event) =>
			# get image which was clicked
			img = event.target
			# create 64base encoded image
			imgdata = @getBase64Image(img)
			# emit data to clients
			@socket.emit 'onimgdata', {  width: img.width, height: img.height, source:imgdata }

	###
	Encode a base64 image based on stackoverflow's "Get image data in Javascript?"
	@see: http://stackoverflow.com/questions/934012/get-image-data-in-javascript
	###
	getBase64Image:(img) ->
		# create canvas
		canvas = document.createElement "canvas"
		canvas.width = img.width
		canvas.height = img.height
		context = canvas.getContext "2d"
		# draw image into canvas
		context.drawImage   img,
							0,
							0

		###
		Get the data-URL formatted image
		using jpeg format as the type of the image to be returned
		@see: http://www.w3.org/TR/html5/the-canvas-element.html
		###
		data = canvas.toDataURL "image/jpeg"

		#return data
		data


module.exports = HomeController