# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :games
end
