class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find(params[:id])
  end

  def find
    respond_with find_customer(params)
  end

  private

    def find_customer
      if params[:id]
        Customer.find_by(id: params[:id])
      elsif params[:first_name]
        Customer.find_by(first_name: params[:first_name])
      elsif params[:last_name]
        Customer.find_by(last_name: params[:last_name])
      end
    end
end
