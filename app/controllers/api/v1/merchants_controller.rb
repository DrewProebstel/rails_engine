class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    merchant = Merchant.find_by_name(params[:name])
    if merchant.nil?
      render json:  MerchantSerializer.new 
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end
