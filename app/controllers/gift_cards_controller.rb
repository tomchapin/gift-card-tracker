class GiftCardsController < ApplicationController
  before_action :set_gift_card, only: [:show, :edit, :update, :destroy]

  # GET /gift_cards
  def index
    @gift_cards = GiftCard.all
  end

  # GET /gift_cards/1
  def show
  end

  # GET /gift_cards/new
  def new
    @gift_card = GiftCard.new
  end

  # GET /gift_cards/1/edit
  def edit
  end

  # POST /gift_cards
  def create
    @gift_card = GiftCard.new(gift_card_params)

    respond_to do |format|
      if @gift_card.save
        format.html { redirect_to @gift_card, notice: 'Gift card was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /gift_cards/1
  def update
    respond_to do |format|
      if @gift_card.update(gift_card_params)
        format.html { redirect_to @gift_card, notice: 'Gift card was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /gift_cards/1
  def destroy
    @gift_card.destroy
    respond_to do |format|
      format.html { redirect_to gift_cards_url, notice: 'Gift card was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gift_card
    @gift_card = GiftCard.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def gift_card_params
    params.require(:gift_card).permit(:card_number, :card_issuer_id)
  end

end
