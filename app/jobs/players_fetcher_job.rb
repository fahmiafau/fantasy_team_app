class PlayersFetcherJob < ApplicationJob
  queue_as :default

  def perform
    data = fetch_players
    save_to_db(data['players']) if data['players']&.length&.positive?
  end

  private

  def fetch_players
    url = 'https://fantasy-stage-api.formula1.com/partner_games/f1/players'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def save_to_db(players_raw_data)
    players_raw_data.each do |player|
      if Player.exists?(player['id'])
        update_player(player)
      else
        create_player(player)
      end
    end
  end

  def create_player(player)
    Player.create(
      id: player['id'],
      first_name: player['first_name'],
      last_name: player['last_name'],
      team_id: player['team_id'],
      price: player['price'],
      is_constructor: player['is_constructor']
    )
  end

  def update_player(player)
    Player.update(
      player['id'],
      first_name: player['first_name'],
      last_name: player['last_name'],
      team_id: player['team_id'],
      price: player['price'],
      is_constructor: player['is_constructor']
    )
  end
end
