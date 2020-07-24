class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts
  #User のインスタンスでインスタンスメソッド microposts が使える。
  #使用例：user.microposts
  #このmicropostsメソッドで、ある User が投稿した Microposts を全件取得できる。
  has_many :relationships
  #自分がフォローしているUserへの参照
  has_many :followings, through: :relationships, source: :follow
  #followingモデルはないので、throughで付け足しをする。
  #relationshipsを中間テーブルとしている。
  #中間テーブルの中のどのカラムを使うかを、source: :followで選択している。
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  #自分をフォローしているUserへの参照
  #User から Relationship を取得するとき、user_id が使用される。
  #だから逆方向ではforeign_key: 'follow_id' と指定し、 user_id 側ではないことを明示。
  has_many :followers, through: :reverses_of_relationship, source: :user
  #user.followings と書いて該当の user がフォローしている User 達を取得するためにhas_many..., through:...を使う。
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
