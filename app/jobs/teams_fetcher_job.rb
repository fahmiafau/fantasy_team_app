class TeamsFetcherJob < ApplicationJob
  queue_as :default

  def perform
    data = fetch_teams
    save_to_db(data['teams']) if data['teams']&.length&.positive?
  end

  private

  def fetch_teams
    url = 'https://fantasy-stage-api.formula1.com/partner_games/f1/teams'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def save_to_db(teams_raw_data)
    teams_raw_data.each do |team|
      if Team.exists?(team['id'])
        update_team(team)
      else
        create_team(team)
      end
    end
  end

  def create_team(team)
    Team.create(
      id: team['id'],
      name: team['name'],
    )
  end

  def update_team(team)
    Team.update(
      team['id'],
      name: team['name'],
    )
  end
end
