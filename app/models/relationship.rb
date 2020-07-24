class Relationship < ApplicationRecord
  belongs_to :user #これは自動でUserを参照することになっているがfollow_idはこの規則にはしたがっていないのでclass_name:'User'を追加する。
  belongs_to :follow, class_name: 'User'
end
