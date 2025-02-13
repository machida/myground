# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :ballpark
  belongs_to :team_home, class_name: 'Team', foreign_key: 'team_home_id'
  belongs_to :team_visitor, class_name: 'Team', foreign_key: 'team_visitor_id'
  has_many :diaries
  has_many :scores
end
