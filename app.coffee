express = require "express"
bodyParser = require "body-parser"
net = require "net"
url = require "url"

app = express()

app.use bodyParser()

app.get "/", (req, res, next) ->
	res.send "How did you get here?"

# https://github.com/hbons/sparkleshare-git-hook/blob/master/post-update
# channel ID is from .sparkleshare file in root directory

app.post "/github/:server?/:channel", (req, res, next) ->
	{server, channel} = req.params
	{hostname, port} = url.parse server if server?

	unless hostname? and port?
		hostname = "notifications.sparkleshare.org"
		port = 443

	{after} = req.body
	return next new Error "No `after` commit hash found in payload." unless after?

	socket = net.connect port, hostname, ->
		console.log "connected to notification server"
		socket.end "announce #{channel} #{after}\n" 

	socket.on "data", (data) ->
		console.log "got data:", data.toString "utf8"

	socket.on "error", (err) ->
		console.log "error:", err
		next err

	socket.on "close", (hadError) ->
		console.log "closed"
		return if hadError
		res.send "YUUUUUP!"

app.listen process.env.PORT or 5009, ->
	{address, port} = @address()
	console.log "Listening on http://#{address}:#{port}"
