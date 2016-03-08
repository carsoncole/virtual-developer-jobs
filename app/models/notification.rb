class Notification < ActiveRecord::Base
  validates :email, presence: true
end
