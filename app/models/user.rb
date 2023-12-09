class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image

  has_many :follow, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy # ① フォローしている人の取得
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # ② フォローされているの人取得

  has_many :follow_user, through: :follow, source: :follower # 自分がフォローしている人
  has_many :follower_user, through: :follower, source: :follow # 自分をフォローしている人

  validates :name, presence: true

  # ユーザーをフォローする
  def is_follow(user_id)
    follow.create(follower_id: user_id)
  end

  # ユーザーのフォローを外す
  def is_unfollow(user_id)
    follow.find_by(follower_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    follow_user.include?(user)
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : '人物のアイコン素材 その3.png'
  end

end
