class Post < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many_attached :post_images

  # has_one_attached :top_image
  # has_one_attached :middle_image
  # has_one_attached :bottom_image

  validates :title,presence:true
  validates :explanation,presence:true#,length:{maximum:200}
  #validates :body_middle,length:{maximum:200}
  #validates :body_bottom,length:{maximum:200}

  scope :is_release, -> { where(is_release: true) } #公開のものだけを取得するクエリ

  scope :is_release_and_active, -> { joins(:user).merge(User.active).where(is_release: true) }#ビューで<% if xxxx.user.is_active %>と書けばいいので必要ないことが発覚したがせっかく作ったので残しておくort

  scope :filter_by_category_and_tags, ->(category, tags) {
    joins(:category, :tags)
      .where(categories: { category_name: category })
      .where(tags: { tag_name: tags })
      .distinct
  }

  scope :filter_by_category, ->(category) {
    joins(:category)
      .where(categories: { category_name: category })
      .distinct
  }

  scope :filter_by_tags, ->(tags) {
    joins(:tags)
      .where(tags: { tag_name: tags })
      .distinct
  }
  
  def get_post_image
    if post_images.attached? && post_images.first.present?
      post_images.first
    else
      'no_image_yoko.jpg'
    end
  end


end
