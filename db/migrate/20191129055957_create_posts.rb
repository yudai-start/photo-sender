class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :image
      t.string :match_face_id
      t.timestamps
    end
  end
end
