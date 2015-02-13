require 'jumpstart_auth'
require 'bitly'
Bitly.use_api_version_3

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing..."
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
    if message.length <= 140
      @client.update(message)
    else
      puts "Error: message was over 140 chars. Tweet not posted."
    end
  end

  def run
    puts "Weolcome to the JSL Twitter Client!"
    command = ""
    while command != 'q'
      printf "enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command
      when 'q' then puts "Goodbye!"
      when 't' then tweet(parts[1..-1].join(" "))
      when 'dm' then dm(parts[1], parts[2..-1].join(" "))
      when 'smf' then spam_my_followers(parts[1..-1].join(" "))
      when 'elt' then everyones_last_tweet
      when 's' then shorten(parts[1])
      when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
      else puts "Sorry, I don't know how to #{command}"
      end
    end
  end

  def dm(target, message)
    screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
    puts "Trying to send #{target} this direct message:"
    if screen_names.include?(target)
      puts message
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "Error: You can only direct message people who are following you."
    end
  end

  def followers_list
    screen_names = []
    @client.followers.each do |follower|
      screen_names << @client.user(follower).screen_name
    end
    screen_names
  end

  def spam_my_followers(message)
    followers_list.each { |follower| dm(follower, message) }
  end

  def everyones_last_tweet
    friends = @client.friends.collect { |friend| @client.user(friend)}
    friends.sort_by! { |friend| friend.screen_name.downcase }
    friends.each do |friend|
      timestamp = friend.status.created_at
      last_message = friend.status.text 
      puts "#{friend.screen_name} said this on #{timestamp.strftime("%A, %b, %d")}"
      puts last_message
      puts ''
    end
  end

  def shorten(original_url)
    puts "Shortening this URL: #{original_url}"
    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    return bitly.shorten(original_url).short_url
    
  end
end

blogger = MicroBlogger.new
blogger.run
