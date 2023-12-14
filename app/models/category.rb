class Category < ApplicationRecord
  
  has_many :posts, dependent: :destroy
  
  validates :category_name, presence: true
  
  
  
end
