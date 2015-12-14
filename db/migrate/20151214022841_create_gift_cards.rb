class CreateGiftCards < ActiveRecord::Migration
  def change
    create_table :gift_cards do |t|
      t.references :card_issuer, index: true, foreign_key: true
      t.string :card_number
      t.monetize :balance, allow_nil: false

      t.timestamps null: false
    end
  end
end
