# frozen_string_literal: true
#
class ExternalRating < ApplicationRecord
  belongs_to :movie, :inverse_of => :external_ratings
end
