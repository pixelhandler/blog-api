class Commenter < ActiveRecord::Base
  has_many :comments

  validates :name, :length => { :minimum => 4 }
  validates :email, uniqueness: true, email: true

  def generate_auth_token
    payload = { commenter_id: self.id }
    AuthToken.encode(payload)
  end

  def self.find_by_email(email)
    self.where(email: email).first
  end
end
