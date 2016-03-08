class Job < ActiveRecord::Base
  acts_as_taggable
  has_one :payment
  validates :company_name, :title, :description, presence: true
end