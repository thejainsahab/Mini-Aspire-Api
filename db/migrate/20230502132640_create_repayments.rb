class CreateRepayments < ActiveRecord::Migration[6.1]
  def change
    create_table :repayments do |t|
      t.date :due_date
      t.float :amount
      t.string :state
      t.integer :loan_id

      t.timestamps
    end
  end
end
