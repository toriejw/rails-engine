class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find(params[:id])
  end

  def find
    respond_with find_merchant(params)
  end

  private

    def find_merchant(params)
      if params[:id]
        Merchant.find_by(id: params[:id])
      elsif params[:name]
        Merchant.find_by(name: params[:name])
      end
    end
end
