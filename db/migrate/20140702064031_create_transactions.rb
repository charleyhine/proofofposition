class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :metadata
      t.string :response

      t.timestamps
    end
  end
end
