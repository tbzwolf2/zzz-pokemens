class SetupController < ApplicationController
  # realisticly this is a terrible endpoint to expose as it could result in a very fun ddos of db
  def setup
    Thread.new { PokemonApiGetter.new}
    render json: {message: "Process started"}, status: 200
  end
end
