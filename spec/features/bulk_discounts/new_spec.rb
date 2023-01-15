require 'rails_helper'

RSpec.describe 'The New Bulk Discount Page', type: :feature do
  let!(:merchant1) { Merchant.create!(name: "Billy's Butters") }
  let!(:merchant2) { Merchant.create!(name: "Sandy's Sandwiches") }

  let!(:item1) { Item.create!(name: "Tissues", description: "Wipes Nose", unit_price: 1000, merchant: merchant1) }
  let!(:item2) { Item.create!(name: "Apples", description: "Delicious", unit_price: 1200, merchant: merchant1) }
  let!(:item3) { Item.create!(name: "Pizza", description: "Cheezy Delicious", unit_price: 1749, merchant: merchant1, status: "enabled") }
  let!(:item4) { Item.create!(name: "Penguins", description: "Exotic pet", unit_price: 100005, merchant: merchant1, status: "enabled") }
  let!(:item5) { Item.create!(name: "Computer Mouse", description: "Moves Cursor", unit_price: 5000, merchant: merchant2) }
  let!(:item6) { Item.create!(name: "Briscuit", description: "Meat", unit_price: 1000, merchant: merchant1) }
  let!(:item7) { Item.create!(name: "Pickles", description: "Dill", unit_price: 1200, merchant: merchant1) }
  let!(:item8) { Item.create!(name: "Headphones", description: "Plays music", unit_price: 1749, merchant: merchant1, status: "enabled") }
  let!(:item9) { Item.create!(name: "Water Bottle", description: "Holds water", unit_price: 1000, merchant: merchant1, status: "enabled") }
  let!(:item10) { Item.create!(name: "Laptop", description: "Writes code", unit_price: 5000, merchant: merchant2) }

  let!(:customer1) {Customer.create!(first_name: "Bob", last_name: "Bobbert")}
  let!(:customer2) {Customer.create!(first_name: "Chad", last_name: "Chaddert")}
  let!(:customer3) {Customer.create!(first_name: "Pete", last_name: "Peterton")}
  let!(:customer4) {Customer.create!(first_name: "Sarah", last_name: "Sarington")}
  let!(:customer5) {Customer.create!(first_name: "Logan", last_name: "Lofferson")}

  let!(:invoice1) {customer1.invoices.create!(status: 1, created_at: "2022-10-25")}
  let!(:invoice2) {customer2.invoices.create!(status: 1)}
  let!(:invoice3) {customer3.invoices.create!(status: 1)}
  let!(:invoice4) {customer4.invoices.create!(status: 1)}
  let!(:invoice5) {customer5.invoices.create!(status: 1)}
  let!(:invoice6) {customer5.invoices.create!(status: 1)}
  
  let!(:invoice_item1) { InvoiceItem.create!(quantity: 1000, unit_price: 1000, item: item1, invoice: invoice1, status: 0) }
  let!(:invoice_item2) { InvoiceItem.create!(quantity: 500, unit_price: 1200, item: item2, invoice: invoice1, status: 1) }
  let!(:invoice_item3) { InvoiceItem.create!(quantity: 100, unit_price: 1749, item: item3, invoice: invoice2, status: 2) }
  let!(:invoice_item4) { InvoiceItem.create!(quantity: 1, unit_price: 100005, item: item4, invoice: invoice3, status: 1) }
  let!(:invoice_item5) { InvoiceItem.create!(quantity: 1, unit_price: 5000, item: item5, invoice: invoice6, status: 0) }
  let!(:invoice_item6) { InvoiceItem.create!(quantity: 30, unit_price: 1000, item: item6, invoice: invoice2, status: 1) }
  let!(:invoice_item7) { InvoiceItem.create!(quantity: 1, unit_price: 1200, item: item7, invoice: invoice3, status: 2) }
  let!(:invoice_item8) { InvoiceItem.create!(quantity: 1, unit_price: 1749, item: item8, invoice: invoice4, status: 1) }
  let!(:invoice_item9) { InvoiceItem.create!(quantity: 1, unit_price: 1000, item: item9, invoice: invoice5, status: 1) }
  let!(:invoice_item10) { InvoiceItem.create!(quantity: 15, unit_price: 1200, item: item2, invoice: invoice2, status: 1) }
  let!(:invoice_item11) { InvoiceItem.create!(quantity: 20, unit_price: 1749, item: item3, invoice: invoice3, status: 2) }
  let!(:invoice_item12) { InvoiceItem.create!(quantity: 30, unit_price: 100005, item: item4, invoice: invoice3, status: 1) }

  let!(:transaction1) { Transaction.create!(result: "success", credit_card_number: 4832483429348594, credit_card_expiration_date: "", invoice: invoice1 ) }
  let!(:transaction2) { Transaction.create!(result: "success", credit_card_number: 4832483429348594, credit_card_expiration_date: "", invoice: invoice2 ) }
  let!(:transaction3) { Transaction.create!(result: "success", credit_card_number: 4832483429348594, credit_card_expiration_date: "", invoice: invoice3 ) }
  let!(:transaction4) { Transaction.create!(result: "success", credit_card_number: 4832483429348594, credit_card_expiration_date: "", invoice: invoice4 ) }
  let!(:transaction5) { Transaction.create!(result: "success", credit_card_number: 4832483429348594, credit_card_expiration_date: "", invoice: invoice5 ) }
  let!(:transaction5) { Transaction.create!(result: "failed", credit_card_number: 4832483429348594, credit_card_expiration_date: "", invoice: invoice6 ) }

  describe 'creating a new bulk discount' do
    it 'will not allow improper inputs' do #us2
      visit merchant_bulk_discounts_path(merchant1)

      within("#create-discount") do
        expect(page).to have_link("Create Bulk Discount", href: new_merchant_bulk_discount_path(merchant1))
        click_link("Create Bulk Discount")
      end 

      expect(current_path).to eq(new_merchant_bulk_discount_path(merchant1))
      
      within("#new-discount-form") do
        fill_in("Discount", with: "")
        fill_in("Quantity", with: 180)
        click_button("Create Bulk Discount")
      end

      expect(page).to have_content("Information Missing or Incorrect")
      expect(current_path).to eq(new_merchant_bulk_discount_path(merchant1))
    end
  end
end