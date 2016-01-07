class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find(params[:id])
  end

  def find
    respond_with Customer.find_by(customer_params)
  end

  def find_all
    respond_with Customer.where(customer_params)
  end

  def random
    respond_with Customer.order("RANDOM()").first
  end

  def customers_transactions
    respond_with Customer.find(params[:id]).transactions
  end

  def customers_invoices
    respond_with Customer.find(params[:id]).invoices
  end

  def favorite_merchant
    respond_with Customer.find(params[:id]).favorite_merchant
  end

  private

    def customer_params
      params.permit(:id, :first_name, :last_name, :updated_at, :created_at)
    end
end
