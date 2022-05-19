class Api::V1::ItemsMerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Item.find(params[:id]).merchant)
  end


end
