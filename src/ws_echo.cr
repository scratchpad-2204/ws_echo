require "kemal"

sockets = Array(HTTP::WebSocket).new

ws "/" do |socket|
  sockets.push socket

  socket.on_close do |_|
    puts "Socket closed."
    sockets.delete(socket)
  end

  socket.on_message do |message|
    puts "Received: #{message}"
    socket.send "ECHO: #{message}"
  end
end

Kemal.run