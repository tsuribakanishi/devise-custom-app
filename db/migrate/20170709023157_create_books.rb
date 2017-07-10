class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.integer :book_id
      t.string :book_name
      t.string :author
      t.integer :kbn1

      t.timestamps
    end
    add_index :books, :book_id, unique: true
  end
end
