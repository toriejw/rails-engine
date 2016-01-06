class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find(params[:id])
  end

  def find
    respond_with Merchant.find_by(merchant_params)
  end

  def find_all
    respond_with Merchant.where(merchant_params)
  end

  def random
    random_id = Merchant.pluck(:id).sample
    respond_with Merchant.find(random_id)
  end

  def merchant_items
    respond_with Merchant.find(params[:id]).items
  end

  def merchant_invoices
    respond_with Merchant.find(params[:id]).invoices
  end

  def most_revenue
    respond_with Merchant.most_revenue(params[:quantity])
  end

  def most_items
    respond_with Merchant.most_items(params[:quantity])
  end

  def favorite_customer
    respond_with Merchant.find(params[:id]).favorite_customer
  end

  private

    def merchant_params
      params.permit(:id, :name, :created_at, :updated_at)
    end
end
