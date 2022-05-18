class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Merchant.find(params[:id]).items)
  end


end
