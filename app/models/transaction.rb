class Transaction < ActiveRecord::Base

  # Associations
  belongs_to :gift_card

  # Custom fields (and their validations)
  monetize :amount_cents

  # Validations
  validates_presence_of :gift_card
  validate :balance_cannot_be_negative

  # Scopes
  default_scope { order('created_at ASC') }

  # Callbacks
  after_create :update_balance

  private

  # Custom validation
  def balance_cannot_be_negative
    if tallied_transaction_amounts + amount_cents < 0
      errors.add(:transaction, 'would cause gift card balance to go negative!')
      return false
    end
    true
  end

  def tallied_transaction_amounts
    gift_card.transactions.sum(:amount_cents)
  end

  def update_balance
    unless gift_card.frozen?
      gift_card.balance_cents = tallied_transaction_amounts
      gift_card.save!
    end
  end

end
