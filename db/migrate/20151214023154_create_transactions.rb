class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :gift_card, index: true, foreign_key: true
      t.monetize :amount, allow_nil: false

      t.timestamps null: false
    end
  end
end
