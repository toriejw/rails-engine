class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find(params[:id])
  end

  def find
    respond_with Transaction.find_by(transaction_params)
  end

  private

    def transaction_params
      params.permit(:invoice_id, :credit_card_number, :result, :created_at, :updated_at)
    end
end
