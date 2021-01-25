class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true, null: false
      t.references :article, foreign_key: true, null: false
      t.timestamps
    end
  end
end
