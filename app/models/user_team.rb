class UserTeam < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }

  belongs_to :user
  has_many :user_team_players, dependent: :destroy
end
