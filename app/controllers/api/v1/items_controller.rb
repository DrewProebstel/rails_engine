class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.new(item_params)
    item.save
    render json: ItemSerializer.new(item), status: :created
  end

  def update
    if Item.exists?(params[:id]) && Merchant.exists?(params[:merchant_id])
      render json: ItemSerializer.new(Item.update(params[:id], item_params))
    elsif Item.exists?(params[:id]) && params[:merchant_id].nil?
      render json: ItemSerializer.new(Item.update(params[:id], item_params))
    else
      render file: "", status: :not_found
    end
  end

  def find_all
    items = Item.find_all_by_name(params[:name])
    if items.nil?
      render json: { data: [] }
    else
      render json: ItemSerializer.new(items)
    end
  end
end


private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
