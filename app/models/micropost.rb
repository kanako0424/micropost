class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  #belongs_to :user の関連付けによって、Micropost のインスタンスでインスタンスメソッド user が使えるようになります
  
  has_many :favorites, dependent: :destroy
  has_many :fovorite_users, through: :favorites, source: :user
end
