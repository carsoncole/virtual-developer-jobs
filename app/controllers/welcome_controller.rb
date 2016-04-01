class WelcomeController < ApplicationController
  def index
    if params[:tags]
      tags = params[:tags].split('_')
      if tags.include? 'front-end-jobs'
        @jobs = Job.tagged_with(["Angular", "Angular.js", "Javascript", "Node.js", "Ember", "Ember.js", "jQuery", "Backbone.js", "Backbone", "React.js"], :any => true).where("published_at > ?", Date.today - 30.days)
      else
        @jobs = Job.tagged_with(tags).where('published_at NOT NULL')
      end
    else
      @jobs = Job.where('published_at NOT NULL')
    end

    @job_banner = @jobs.order('rank DESC, published_at DESC').limit(1).first
    @jobs = @jobs.order('published_at DESC').where.not(id: @job_banner.id)

    @all_tags = ActsAsTaggableOn::Tag.most_used(12).map {|t| t.name }.delete_if{|x| ['CSS', 'HTML', 'HTML5'].include? x }
    @param_tags = params[:tags].split("_") if params[:tags]
    
    if @param_tags
      @param_tags.each do |t|
        @all_tags << t unless @all_tags.include? t
      end
    end

    @meta_title = 'Job Site for Virtual and Remote Jobs'
  end
end
