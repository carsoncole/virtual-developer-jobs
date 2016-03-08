class WelcomeController < ApplicationController
  def index
    @jobs = Job.where('published_at NOT NULL').order('published_at DESC')
  end
end
