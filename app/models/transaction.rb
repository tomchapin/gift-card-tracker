class Transaction < ActiveRecord::Base
  belongs_to :gift_card

  monetize :amount_cents

end
