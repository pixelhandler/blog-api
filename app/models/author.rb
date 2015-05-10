class Author < ActiveRecord::Base
  has_many :posts

  validates :name, :length => { :minimum => 4 }
  validates :email, uniqueness: true, email: true
end
