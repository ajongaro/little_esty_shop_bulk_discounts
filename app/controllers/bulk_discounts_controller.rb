class BulkDiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :new, :create]
  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
  end

  def create
    discount = BulkDiscount.new(merchant_id: @merchant.id, discount: params[:discount], quantity: params[:quantity])
    if discount.save
      flash.notice = "Bulk Discount Created!"
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash.notice = "Information Missing or Incorrect"
      redirect_to new_merchant_bulk_discount_path(@merchant)
    end
  end

  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end