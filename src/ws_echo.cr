require "kemal"

sockets = Array(HTTP::WebSocket).new

ws "/" do |socket|
  sockets.push socket

  socket.on_close do |_|
    sockets.delete(socket)
  end

  socket.on_message do |message|
    socket.send "ECHO: #{message}"
  end
end

Kemal.run