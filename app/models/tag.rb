class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts

  validates :name, :length => { :minimum => 2 }, uniqueness: true
end
