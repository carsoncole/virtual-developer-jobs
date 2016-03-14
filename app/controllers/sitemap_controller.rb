class SitemapController < ApplicationController

  def index
    @jobs = Job.where("published_at > ?", Date.today - 30.days).order('published_at DESC')
  end

end
