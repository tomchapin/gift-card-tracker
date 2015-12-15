class TransactionsController < ApplicationController

  # POST /gift_cards/:gift_card_id/transactions
  def create
    @gift_card = GiftCard.find(params[:gift_card_id])
    @transaction = @gift_card.transactions.build(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to gift_card_path(@gift_card), notice: 'Transaction was successfully created.' }
      else
        format.html { redirect_to gift_card_path(@gift_card), error: "Unable to add transaction! (#{@transaction.errors.full_messages.first})" }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def transaction_params
    params.require(:transaction).permit(:gift_card_id, :amount)
  end

end
