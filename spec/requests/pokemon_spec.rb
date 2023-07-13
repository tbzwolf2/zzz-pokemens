require "rails_helper"

RSpec.describe "Pokemons", type: :request do
  before do
  end

  describe "GET /index" do
    it "returns all pokemon" do
      (1..10).each { |i| FactoryBot.create(:pokemon,:id => i) }
      get "/api/v1/pokemon"

      expect(json.size).to eq(10)
      expect(response.status).to eq(200)
    end

    it "returns 100 pokemon" do
      (1..120).each { |i| FactoryBot.create(:pokemon,:id => i) }
      get "/api/v1/pokemon"

      expect(json.size).to eq(100)
      expect(response.status).to eq(200)
    end

    it "returns 100 pokemon starting from id 200" do
      (200..300).each { |i| FactoryBot.create(:pokemon,:id => i) }
      get "/api/v1/pokemon?pagination=200"

      expect(json.size).to eq(100)
      expect(json.first["id"]).to eq(200)
      expect(response.status).to eq(200)
    end

    it "returns pokemon type in hash" do
      poke = FactoryBot.create(:pokemon,:id => 1) 

      type = FactoryBot.create(:type) 
      PokemonsType.create(
        pokemon_id: poke.id,
        type_id: type.id
      )

      get "/api/v1/pokemon"
      expect(json.first["types"][0]).to eq(type.attributes.except("created_at", "updated_at", "id"))
      expect(response.status).to eq(200)
    end


    it "returns an error if there are no pokemon or an out of bounds pagiantion is used" do
      get "/api/v1/pokemon"
      expect(json["error"]).to eq("No pokemans found! :(")
      (1..120).each { |i| FactoryBot.create(:pokemon,:id => i) }
      expect(response.status).to eq(404)

      get "/api/v1/pokemon?pagination=2000000"
      expect(json["error"]).to eq("No pokemans found! :(")
      expect(response.status).to eq(404)
    end
  end

  describe "GET /index/:id" do 
    it "returns all pokemon attributes" do
      poke = FactoryBot.create(:pokemon,:id => 6) 
      get "/api/v1/pokemon/6"

      expect(json).to eq(poke.attributes.except("created_at", "updated_at"))
      expect(response.status).to eq(200)
    end

    it "returns all pokemon attributes by using name in place of id" do
      poke = FactoryBot.create(:pokemon,:name => "bulbasaur") 
      get "/api/v1/pokemon/#{poke.name}"

      expect(json).to eq(poke.attributes.except("created_at", "updated_at"))
      expect(response.status).to eq(200)
    end

    it "returns an error if the pokemon doesnt exist" do
      get "/api/v1/pokemon/1"
      expect(json["error"]).to eq("Couldn't find pokemon :(")
      expect(response.status).to eq(404)

      get "/api/v1/pokemon/pika"
      expect(json["error"]).to eq("Couldn't find pokemon :(")
      expect(response.status).to eq(404)
    end
  end

end
