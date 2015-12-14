class GiftCard < ActiveRecord::Base
  belongs_to :card_issuer
  has_many :transactions

  monetize :balance_cents

end
