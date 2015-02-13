require 'socket'
require 'json'

server = TCPServer.open(2000)
loop {
  client = server.accept
  request = client.recv(2000)
  request_type = request.match(/\w+/)
  request_file = request.match(/\w+ \/(\S+)/)
  request_http = request.match(/(\S+)\s*$/)
  if request_type == 'POST'
    request_size = request.match(/Content-Length: (\d+)/)
    json_data = request[-request_size[1].to_i..-1]
    params = {}; params << JSON.parse(json_data)
    post_data = "<li>Name: #{params[:viking][:name]}</li><li>Email: #{params[:viking][:email]}</li>"
  end
    
  if File.exist?(request_file[1])
    file = File.read(request_file[1])
    status = "200 OK"
  else
    status = "404 Not Found"
  end

  response = "#{request_http[1]} #{status}\n"\
             "Date: #{Time.now}\n"\
             "Content-Type: text/html\n"\
             "Content-Length: #{file.size}\r\n\r\n"

  case request_type[0]
  when 'GET'
    if status == "200 OK"
      client.puts response
      client.puts file
    elsif status == "404 Not Found"
      client.puts response
      client.puts "Error: The file you requested doesn't exist."
    else
    end
  when 'POST'
    if status == "200 OK"
      client.puts response
      client.puts json_data
      client.puts params
      client.puts post_data
      # client.puts file.gsub("<%= yield %>", post_data)
    elsif status == "404 Not Found"
      client.puts response
      client.puts "Error: The file you request doesn't exist."
    else
    end
  else
  end

  client.puts(Time.now.ctime)
  client.puts "Closing the connection. Bye!"
  client.close
}

# Testing:
# data = "json data goes here"
# test = "GET /index.html HTTP/1.0\n"\
#        "From: email address\n"\
#        "User-Agent: Simple Browser\n"\
#        "Content-Length: #{data.size}\r\n\r\n"\
#        "#{data}"

# test_type = test.match(/\w+/)
# test_file = test.match(/^\w+ \/(\S+)/)
# test_http = test.match(/(\S+)\s*$/)
# test_size = test.match(/Content-Length: (\d+)/)


# json_data = test[-test_size[1].to_i..-1]

# p test_type[0]
# p test_file[1]
# p test_http[1]
# p test_size[1]
# puts json_data

# if File.exist?(test_file[1])
#   file = File.open(test_file[1])
#   status = "200 OK"
# else
#   status = "404 Not Found"
# end
# response = "#{test_http[1]} #{status}\n"\
#            "Date: #{Time.now}\n"\
#            "Content-Type: text/html\n"\
#            "Content-Length: #{file.size}"

# # puts response
# # puts file.read
