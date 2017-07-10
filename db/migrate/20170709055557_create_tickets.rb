class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :tiket_id
      t.integer :book_id
      t.integer :user_id
      t.datetime :return_date
      t.boolean :return_flg

      t.timestamps
    end
    add_index :tickets, :tiket_id, unique: true
  end
end
