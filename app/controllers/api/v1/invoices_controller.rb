class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find(params[:id])
  end

  def find
    respond_with Invoice.find_by(invoice_params)
  end

  def find_all
    respond_with Invoice.where(invoice_params)
  end

  def random
    random_id = Invoice.pluck(:id).sample
    respond_with Invoice.find(random_id)
  end

  def invoice_transactions
    respond_with Invoice.find(params[:id]).transactions
  end

  private

    def invoice_params
      params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
    end
end
