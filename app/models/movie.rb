# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :external_ratings, :inverse_of => :movie, dependent: delete_all

  scope :outdated, -> { where('updated_at < ?', 2.days.ago) }
end
