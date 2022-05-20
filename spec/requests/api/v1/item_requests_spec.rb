require 'rails_helper'

describe "Items API" do
  it "sends a list of merchants" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    create_list(:item, 5, merchant_id: merchant_1.id)
    create_list(:item, 3, merchant_id: merchant_2.id)
    create_list(:item, 10, merchant_id: merchant_3.id)

    get "/api/v1/items"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items.count).to eq(18)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:type]).to eq("item")

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
    end
  end

  it "always returns an array of data, even if one resource is found" do
  merchant = create(:merchant)

  create(:item, merchant_id: merchant.id)

  get "/api/v1/items"

  expect(response).to be_successful

  response_body = JSON.parse(response.body, symbolize_names: true)
  items = response_body[:data]

  expect(items).to be_an Array
  expect(items.count).to eq(1)
  end

  it "always returns an array of data, even if no resources are found" do
    get "/api/v1/items"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items).to be_an Array
    expect(items.count).to eq(0)
  end

  it "index renders a JSON representation of a the corresponding record" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id, description: "Eat it", unit_price: 300, name: "Dog Food")
    get "/api/v1/items/#{item.id}"
    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(item[:attributes][:name]).to eq("Dog Food")
    expect(item[:attributes][:description]).to eq("Eat it")
    expect(item[:attributes][:unit_price]).to eq(300.0)

  end

  it "can create a new item" do
  merchant = create(:merchant)

  item_info = {
    name: "Big gun that shoots swords but the swords are actually guns that shoot more small guns instead of bullets",
    description: "See name",
    unit_price: 1000,
    merchant_id: merchant.id
  }
  headers = {"CONTENT_TYPE" => "application/json"}

  post "/api/v1/items", headers: headers, params: JSON.generate(item: item_info)

  response_body = JSON.parse(response.body, symbolize_names: true)
  binding.pry
  item = response_body[:data]

  expect(response).to be_successful
  expect(item[:attributes][:name]).to eq("Big gun that shoots swords but the swords are actually guns that shoot more small guns instead of bullets")
  expect(item[:attributes][:description]).to eq("See name")
  expect(item[:attributes][:unit_price]).to eq(1000)
  expect(item[:attributes][:merchant_id]).to eq(merchant.id)
end

end
