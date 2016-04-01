namespace :ranker do
  desc "Process runs"

  task :run => :environment do
    Ranker.run
  end
end