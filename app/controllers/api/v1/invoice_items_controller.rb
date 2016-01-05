class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find(params[:id])
  end

  def find
    respond_with find_invoice_item(params)
  end

  private

    def find_invoice_item(params)
      if params[:id]
        InvoiceItem.find_by(id: params[:id])
      elsif params[:item_id]
        InvoiceItem.find_by(item_id: params[:item_id])
      elsif params[:invoice_id]
        InvoiceItem.find_by(invoice_id: params[:invoice_id])
      elsif params[:quantity]
        InvoiceItem.find_by(quantity: params[:quantity])
      elsif params[:unit_price]
        InvoiceItem.find_by(unit_price: params[:unit_price])
      end
    end
end
