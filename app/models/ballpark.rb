# frozen_string_literal: true

class Ballpark < ApplicationRecord
  has_many :games, dependent: :destroy
  validates :name, presence: true
end
