RSpec.describe 'The Bulk Discount Show Page', type: :feature do
  let!(:merchant1) { Merchant.create!(name: "Billy's Butters") }
  let!(:merchant2) { Merchant.create!(name: "Sandy's Sandwiches") }

  let!(:bulk_discount1) { BulkDiscount.create!(discount: "20%", quantity: 90, merchant: merchant1) } 
  let!(:bulk_discount2) { BulkDiscount.create!(discount: "15%", quantity: 10, merchant: merchant1) } 
  let!(:bulk_discount3) { BulkDiscount.create!(discount: "10%", quantity: 20, merchant: merchant2) } 
  let!(:bulk_discount4) { BulkDiscount.create!(discount: "30%", quantity: 50, merchant: merchant2) } 

  describe 'the bulk discount show page' do
    it 'shows a specific bulk discount for a merchant' do #us4
      visit merchant_bulk_discount_path(merchant1, bulk_discount1)

      expect(page).to have_content(merchant1.name)
      expect(page).to have_content(bulk_discount1.discount, count: 1)
      expect(page).to have_content(bulk_discount1.quantity, count: 1)
    end

    it 'each discount listed has a link to that discounts show page' do #us4
      visit merchant_bulk_discount_path(merchant2, bulk_discount3)

      expect(page).to have_content(merchant2.name)
      expect(page).to have_content(bulk_discount3.discount, count: 1)
      expect(page).to have_content(bulk_discount3.quantity, count: 1)
    end
  end
end