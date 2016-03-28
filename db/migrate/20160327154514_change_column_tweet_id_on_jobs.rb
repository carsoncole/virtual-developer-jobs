class ChangeColumnTweetIdOnJobs < ActiveRecord::Migration
  def change
    change_column :jobs, :tweet_id, :string
  end
end
