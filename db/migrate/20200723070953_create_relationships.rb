class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :users }

      t.timestamps
      
      t.index [:user_id, :follow_id], unique: true
      #user_idとfollow_idのペアで重複するものが保存されないようにするための
      #データベースの設定
    end
  end
end
