class Job < ActiveRecord::Base
  validates :company_name, :title, :description, presence: true
end