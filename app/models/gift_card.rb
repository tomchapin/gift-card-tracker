class GiftCard < ActiveRecord::Base

  # Associations
  belongs_to :card_issuer
  has_many :transactions, dependent: :destroy

  # Custom fields (and their validations)
  monetize :balance_cents

  # Validations
  validates_presence_of :card_issuer
  validates :card_number, presence: true, credit_card_number: { message: 'must be a valid credit card number' }

  # Scopes
  default_scope { order('created_at ASC') }

end
