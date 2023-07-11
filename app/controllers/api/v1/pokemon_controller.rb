class Api::V1::PokemonController < ApplicationController
  def index
    if params[:pagination]
      pagination = params[:pagination].to_i
    else
      pagination = 1
    end
    # Paginated with 100 records each
    @pokemens = Pokemon.where(id: pagination..(pagination + 100)).map{|poke| {id: poke.id, name: poke.name, types: poke.type_details}}

    unless @pokemens.count == 0 
      render json: @pokemens
    else
      render json:  {error: "No pokemans found! :("}
    end
  end

  def show
    @pokemon = Pokemon.find_by_name_or_id(params[:id])
    if @pokemon
      render json: @pokemon
    else
      render json: {error: "Couldn't find pokemon :("}
    end
  end
end
