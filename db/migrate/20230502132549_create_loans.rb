class CreateLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :loans do |t|
      t.float :amount
      t.integer :term
      t.string :state
      t.integer :user_id

      t.timestamps
    end
  end
end
