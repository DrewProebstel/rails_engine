require 'rails_helper'


describe "Merchants API" do
  it "sends a list of Merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  xit "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(book).to have_key(:id)
    expect(book[:id]).to eq(id)


  end
end
