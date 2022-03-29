class Api::V1::MerchantItemsController < ApplicationController

  def index
    render json: MerchantItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
  end
end
