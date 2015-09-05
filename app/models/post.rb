class Post < ActiveRecord::Base
  belongs_to :author
  has_many :comments, -> { where(approved: true) }, :dependent => :destroy
  has_and_belongs_to_many :tags

  validates :slug, uniqueness: true

  def to_param
    slug
  end
end
