# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMovieWorker do
  subject { described_class.new }

  let(:title) { 'Some+Like+It+Hot' }

  it 'adds a movie record to the database' do
    VCR.use_cassette 'movie_request_some_like_it_hot' do
      expect { subject.perform(title) }.to change(Movie, :count).by(1)
    end
  end
end
