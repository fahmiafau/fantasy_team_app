class UserTeam < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }

  has_many :user_team_players, dependent: :destroy
end
