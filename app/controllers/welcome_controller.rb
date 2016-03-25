class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @jobs = Job.tagged_with(params[:tag]).where('published_at NOT NULL').order('published_at DESC')
    else
      @jobs = Job.where('published_at NOT NULL').order('published_at DESC')
    end
    @meta_title = 'Job Site for Virtual and Remote Jobs'
  end
end
