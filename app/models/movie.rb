# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  scope :outdated, -> { where('updated_at < ?', 2.days.ago) }
end
