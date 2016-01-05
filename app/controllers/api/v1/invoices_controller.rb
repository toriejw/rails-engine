class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find(params[:id])
  end

  def find
    respond_with find_invoice(params)
  end

  private

    def find_invoice(params)
      if params[:id]
        Invoice.find_by(id: params[:id])
      elsif params[:customer_id]
        Invoice.find_by(customer_id: params[:customer_id])
      elsif params[:merchant_id]
        Invoice.find_by(merchant_id: params[:merchant_id])
      elsif params[:status]
        Invoice.find_by(status: params[:status])
      end
    end
end
