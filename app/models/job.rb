class Job < ActiveRecord::Base
  acts_as_taggable_on :skills
  has_one :payment
  validates :company_name, :title, :company_email, :description, :how_to_apply, presence: true
  validates :company_name, length: { maximum: 45 }
  validates :title, length: { maximum: 60 }
end