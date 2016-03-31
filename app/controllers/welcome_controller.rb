class WelcomeController < ApplicationController
  def index
    if params[:tags]
      tags = params[:tags].split('_')
      if tags.include? 'front-end-jobs'
        @jobs = Job.tagged_with(["Angular", "Angular.js", "Javascript", "Node.js", "Ember", "Ember.js", "jQuery", "Backbone.js", "Backbone", "React.js"], :any => true).where("published_at > ?", Date.today - 30.days)
      else
        @jobs = Job.tagged_with(tags).where('published_at NOT NULL').order('published_at DESC')
      end
    else
      @jobs = Job.where('published_at NOT NULL').order('published_at DESC')
    end
    @job_banner = @jobs.first
    @meta_title = 'Job Site for Virtual and Remote Jobs'
  end
end
