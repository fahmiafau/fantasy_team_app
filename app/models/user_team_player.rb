class UserTeamPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :user_team
end
