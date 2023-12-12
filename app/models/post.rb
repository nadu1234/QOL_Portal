class Post < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :top_image
  has_one_attached :middle_image
  has_one_attached :bottom_image

  validates :title,presence:true
  validates :body_top,presence:true#,length:{maximum:200}
  #validates :body_middle,length:{maximum:200}
  #validates :body_bottom,length:{maximum:200}
  
  scope :is_release, -> { where(is_release: true) } #公開のものだけを取得するクエリ
  
end
