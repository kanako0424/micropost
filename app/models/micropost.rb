class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  #belongs_to :user の関連付けによって、Micropost のインスタンスでインスタンスメソッド user が使えるようになります
  
  has_many :reverses_of_fav, class_name: 'favorite', foreign_key: 'user_id'
  has_many :fovorites, through: :reverses_of_fav, source: :user
end
