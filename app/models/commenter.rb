require 'digest'

class Commenter < ActiveRecord::Base
  before_save :create_hash

  has_many :comments

  validates :name, :length => { :minimum => 4 }
  validates :email, uniqueness: true, email: true
  validates :email, uniqueness: true, email: true

  def generate_auth_token
    payload = { commenter_id: self.id }
    AuthToken.encode(payload)
  end

  def create_hash
    md5 = Digest::MD5.new
    md5 << self.email
    self.email_hash = md5.hexdigest
  end

  def self.find_by_email(email)
    self.where(email: email).first
  end
end
