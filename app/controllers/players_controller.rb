class PlayersController < ApplicationController
  def index
    @players = Player.includes(:team).all
  end
end
