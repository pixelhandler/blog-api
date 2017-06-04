class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  validates :name, :length => { :minimum => 2 }, uniqueness: true
  validates :slug, :length => { :minimum => 2 }, uniqueness: true

  def to_param
    slug
  end
end
