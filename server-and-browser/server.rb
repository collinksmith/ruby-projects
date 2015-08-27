require 'socket'
require 'json'

server = TCPServer.open(2000)
loop {
  client = server.accept
  request = client.recv(2000)
  request_type = request.match(/\w+/)
  request_file = request.match(/\w+ \/(\S+)/)
  request_http = request.match(/(\S+)\s*$/)
    
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
    request_size = request.match(/Content-Length: (\d+)/)
    json_data = request[-request_size[1].to_i..-1]
    params = JSON.parse(json_data)
    post_data = "<li>Name: #{params['viking']['name']}</li><li>Email: #{params['viking']['email']}</li>"
    if status == "200 OK"
      client.puts response
      client.puts file.gsub("<%= yield %>", post_data)
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