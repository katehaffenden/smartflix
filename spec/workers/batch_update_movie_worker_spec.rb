# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BatchUpdateMovieWorker do
  subject { described_class.new }

  let!(:movie) { create(:movie, title: 'The Godfather', year: 1971) }

  it 'updates the movie' do
    VCR.use_cassette 'movie_request_the_godfather' do
      subject.perform

      expect(movie.reload).to have_attributes(year: 1972, genre: 'Crime, Drama')
    end
  end
end
