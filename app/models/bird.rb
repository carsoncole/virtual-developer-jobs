class Bird

  def ruby_on_rails
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = AUTHENTICATION["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = AUTHENTICATION["TWITTER_CONSUMER_SECRET"]
      config.access_token        = AUTHENTICATION["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = AUTHENTICATION["TWITTER_ACCESS_TOKEN_SECRET"]
    end

    jobs = Job.tagged_with("Ruby on Rails").where("published_at > ?", Date.today - 30.days)
    message = "Our #{jobs.size} current remote Ruby on Rails jobs https://virtualdeveloperjobs.com/?tag=Ruby%20on%20Rails #RoR #rubyonrails #RemoteJob"
    tweet = client.update(message)
  end


  def front_end
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = AUTHENTICATION["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = AUTHENTICATION["TWITTER_CONSUMER_SECRET"]
      config.access_token        = AUTHENTICATION["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = AUTHENTICATION["TWITTER_ACCESS_TOKEN_SECRET"]
    end

    jobs = Job.tagged_with(["Angular", "Angular.js", "Javascript", "Node.js", "Ember", "Ember.js", "jQuery", "Backbone.js", "Backbone", "React.js"], :any => true).where("published_at > ?", Date.today - 30.days)
    message = "Front-end devs, here's #{jobs.size} remote jobs available https://virtualdeveloperjobs.com/?tag=front-end-jobs #UX #RemoteJob"
    tweet = client.update(message)
  end


end