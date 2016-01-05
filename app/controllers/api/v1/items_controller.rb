class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find(params[:id])
  end

  def find
    respond_with Item.find_by(item_params)
  end

  def find_all
    respond_with Item.where(item_params)
  end

  def random
    random_id = Item.pluck(:id).sample
    respond_with Item.find(random_id)
  end

  private

    def item_params
      params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
    end
end
