class AddTweetedToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :tweeted_at, :datetime
    add_column :jobs, :tweet_id, :integer
  end
end
