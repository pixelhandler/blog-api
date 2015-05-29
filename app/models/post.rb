class Post < ActiveRecord::Base
  belongs_to :author
  has_many :comments, -> { where(approved: true) }

  validates :slug, uniqueness: true

  def to_param
    slug
  end
end
