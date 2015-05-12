class Comment < ActiveRecord::Base
  belongs_to :commenter
  belongs_to :post

  validates :body, :length => { :minimum => 2 }

  scope :approved, -> { where(approved: true) }
end
