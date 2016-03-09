class Notification < ActiveRecord::Base
  validates :email, presence: true

  before_save :downcase_email!

  private

  def downcase_email!
    self.email = email.downcase
  end
end
