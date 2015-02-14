require 'socket'
require 'json'

host = 'localhost'                  # The web server
port = 2000                         # Default HTTP port
path = '/thanks.html'               # The file we want

puts "Which type of request do you want to send?"
type = gets.chomp.strip.upcase
if type == 'POST'
  puts "Enter a name"
  name = gets.chomp
  puts "Enter an email address"
  email = gets.chomp
  res = {:viking => {:name=>name, :email=>email} }.to_json
end

# This is the HTTP request we want to send to fetch a file.
if type == 'GET'
  request = "GET #{path} HTTP/1.0\n"\
            "From: email address\n"\
            "User-Agent: Simple Browser\r\n\r\n"
elsif type == 'POST'
  request = "POST #{path} HTTP/1.0\n"\
            "From: #{email}\n"\
            "User-Agent: Simple Browser\n"\
            "Content-Length: #{res.size}\r\n\r\n"\
            "#{res}"
end


socket = TCPSocket.open(host,port) # Connect to server
socket.print(request)              # Send request
response = socket.read             # Read complete response

# Split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2)
print body                         # Display it
socket.close
