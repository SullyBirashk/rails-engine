require 'rails_helper'

describe "Search Request" do
  it "searching names of merchants" do
    id = create(:merchant).id
    id_2 = create(:merchant).id

    item_1 = Item.create!(name: "pencil", description: "soft", unit_price: 21.99, merchant_id: id)
    item_2 = Item.create!(name: "pen", description: "hard", unit_price: 22.99, merchant_id: id)
    item_3 = Item.create!(name: "item 3", description: "rubbbery", unit_price: 23.99, merchant_id: id_2)
    item_4 = Item.create!(name: "item 4", description: "silky", unit_price: 24.99, merchant_id: id_2)

    get "/api/v1/merchants/find?name=pen"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(4)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end
end
