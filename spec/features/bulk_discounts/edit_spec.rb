require 'rails_helper'

RSpec.describe 'The Bulk Discount Edit Page', type: :feature do
  let!(:merchant1) { Merchant.create!(name: "Billy's Butters") }
  let!(:merchant2) { Merchant.create!(name: "Sandy's Sandwiches") }

  let!(:bulk_discount1) { BulkDiscount.create!(discount: "20%", quantity: 90, merchant: merchant1) } 
  let!(:bulk_discount2) { BulkDiscount.create!(discount: "15%", quantity: 10, merchant: merchant1) } 
  let!(:bulk_discount3) { BulkDiscount.create!(discount: "10%", quantity: 20, merchant: merchant2) } 
  let!(:bulk_discount4) { BulkDiscount.create!(discount: "30%", quantity: 50, merchant: merchant2) } 

  describe 'editing a bulk discount' do
    it 'has fields to update a bulk discount' do
      visit edit_merchant_bulk_discount_path(merchant1, bulk_discount1)      

      expect(bulk_discount1.discount).to eq("20%")
      expect(bulk_discount1.quantity).to eq(90)

      expect(page).to have_field("Discount", with: "20%")
      expect(page).to have_field("Quantity", with: 90)

      fill_in("Discount", with: "80%")
      fill_in("Quantity", with: "3")
      click_button("Update Discount")
      
      expect(current_path).to eq(merchant_bulk_discount_path(merchant1, bulk_discount1))

      bulk_discount1.reload
      expect(bulk_discount1.discount).to eq("80%")
      expect(bulk_discount1.quantity).to eq(3)
    end
  end
end