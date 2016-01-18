class Post < ActiveRecord::Base
  belongs_to :author
  has_many :comments, -> { where(approved: true) }, :dependent => :destroy
  has_and_belongs_to_many :tags

  validates :slug, uniqueness: true
  validates :title, presence: true, length: { minimum: 10 }

  def to_param
    slug
  end

  def self.search(terms)
    if terms.blank?
      none
    else
      terms = CGI.unescape(terms)
      query = sanitize_sql_array(["to_tsquery('pg_catalog.english', ?)", terms.gsub(/\s/," & ")])
      self.where("tsv @@ #{query}").order("ts_rank_cd(tsv, #{query}) DESC")
    end
  end
end
