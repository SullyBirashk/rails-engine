require 'rails_helper'

describe "Item API" do
  it "sends a list of Items (index)" do
    id = create(:merchant).id
    id_2 = create(:merchant).id

    item_1 = Item.create!(name: "item 1", description: "soft", unit_price: 21.99, merchant_id: id)
    item_2 = Item.create!(name: "item 2", description: "hard", unit_price: 22.99, merchant_id: id)
    item_3 = Item.create!(name: "item 3", description: "rubbbery", unit_price: 23.99, merchant_id: id_2)
    item_4 = Item.create!(name: "item 4", description: "silky", unit_price: 24.99, merchant_id: id_2)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

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

  it "finds an Items (show)" do
    id = create(:merchant).id
    id_2 = create(:merchant).id

    item_1 = Item.create!(name: "item 1", description: "soft", unit_price: 21.99, merchant_id: id)
    item_2 = Item.create!(name: "item 2", description: "hard", unit_price: 22.99, merchant_id: id)
    item_3 = Item.create!(name: "item 3", description: "rubbbery", unit_price: 23.99, merchant_id: id_2)
    item_4 = Item.create!(name: "item 4", description: "silky", unit_price: 24.99, merchant_id: id_2)

    get "/api/v1/items/#{item_3.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it "can create an item (create)" do
    id = create(:merchant).id

    post "/api/v1/items?name=item_5&&description=bumpy&&unit_price=25.99&&merchant_id=#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(Item.count).to eq(1)

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it "can edit an item (put)" do
    id = create(:merchant).id
    id_2 = create(:merchant).id

    item_1 = Item.create!(name: "item 1", description: "soft", unit_price: 21.99, merchant_id: id)
    item_2 = Item.create!(name: "item 2", description: "rubbbery", unit_price: 23.99, merchant_id: id_2)

    patch "/api/v1/items/#{item_2.id}?name=item_5&&description=bumpy&&unit_price=25.99&&merchant_id=#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it "can destroy an item (destroy)" do
    id = create(:merchant).id

    item = Item.create!(name: "item 1", description: "soft", unit_price: 21.99, merchant_id: id)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    expect(Item.count).to eq(0)

    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can show an items merchant" do
    id = create(:merchant).id
    id_2 = create(:merchant).id

    item_1 = Item.create!(name: "item 1", description: "soft", unit_price: 21.99, merchant_id: id)
    item_2 = Item.create!(name: "item 2", description: "rubbbery", unit_price: 23.99, merchant_id: id_2)

    get "/api/v1/items/#{item_2.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_an(String)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end
