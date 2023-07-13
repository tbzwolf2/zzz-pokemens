class Api::V1::PokemonController < ApplicationController

  swagger_controller :pokemon, "Pokemon access"

  # swagger_api :index do
  #   summary "Fetches all Pokemon"
  #   notes "Shows basic Pokemon info and types"
  #   param :query, :pagination, :integer, :optional, "Pagination number"
  #   response :not_found, "The database lacks any Pokemon"
  # end

  # swagger_api :show do
  #   summary "Fetches a single Pokemon"
  #   param :path, :id_or_name, :string, :optional, "Id or name"
  #   response :ok, "Success", :Pokemon
  #   response :not_found, "The database lacks the Pokemon"
  # end

  def index
    if params[:pagination]
      pagination = params[:pagination].to_i
    else
      pagination = 1
    end
    # Paginated with 100 records each, use includes to load types all at once rather than per pokemon 
    # If this format was to be used elsewhere I would make a method as this is pretty ugly

    @pokemens = Pokemon.includes(pokemons_types: :type).where(id: pagination..(pagination + 99)).map{|poke| 
    { 
      id: poke.id, 
      name: poke.name,
      types: poke.pokemons_types.each.map {
        |pt| {name: pt.type.name, damage_relations: pt.type.damage_relations}} }
    }



    unless @pokemens.count == 0 
      render json: @pokemens, status: 200
    else
      render json:  {error: "No pokemans found! :("}, status: 404
    end
  end

  def show
    @pokemon = Pokemon.find_by_name_or_id(params[:id])
    if @pokemon
      render json: @pokemon.attributes.except("created_at", "updated_at"), status: 200
    else
      render json: {error: "Couldn't find pokemon :("}, status: 404
    end
  end
end
