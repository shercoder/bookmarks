class CreateBookmarks < ActiveRecord::Migration
  def change
  	create_table :bookmarks do |t|
  	  t.integer :user_id
      t.string :url
      t.string :title
      t.text :notes
      t.integer :rating
      t.boolean :private
      t.integer :view_count
 
      t.timestamps
    end
  end
end
