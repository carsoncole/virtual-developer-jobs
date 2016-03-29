class Bird

  def ruby_on_rails
    set_twitter_connection
    jobs = Job.tagged_with("Ruby on Rails").by_published_at.where("published_at > ?", Date.today - 30.days)
    message = "Our #{jobs.size} current remote Ruby on Rails jobs https://virtualdeveloperjobs.com/?tag=Ruby%20on%20Rails #RoR #RemoteJob"
    tweet = client.update(message)
  end


  private

  def set_twitter_connection
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = AUTHENTICATION["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = AUTHENTICATION["TWITTER_CONSUMER_SECRET"]
      config.access_token        = AUTHENTICATION["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = AUTHENTICATION["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end
end