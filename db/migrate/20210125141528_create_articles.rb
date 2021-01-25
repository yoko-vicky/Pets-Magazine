class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
      t.references :author, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
