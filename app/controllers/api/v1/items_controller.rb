class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find(params[:id])
  end

  def find
    respond_with find_item(params)
  end

  private

    def find_item(params)
      if params[:id]
        Item.find_by(id: params[:id])
      elsif params[:name]
        Item.find_by(name: params[:name])
      elsif params[:description]
        Item.find_by(description: params[:description])
      elsif params[:unit_price]
        Item.find_by(unit_price: params[:unit_price])
      elsif params[:merchant_id]
        Item.find_by(merchant_id: params[:merchant_id])
      end
    end
end
