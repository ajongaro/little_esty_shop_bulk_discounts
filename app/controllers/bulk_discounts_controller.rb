class BulkDiscountsController < ApplicationController
  before_action :find_merchant
  before_action :find_bulk_discount, only: [:show, :destroy, :edit]

  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
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

  def edit
  end

  def destroy
    if @bulk_discount.destroy
      flash.notice = "Bulk Discount Deleted!"
    end
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end
end