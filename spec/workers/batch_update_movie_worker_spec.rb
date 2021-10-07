# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BatchUpdateMovieWorker do
  subject { described_class.new }

  let!(:movie) { create(:movie, title: 'The Godfather', year: 1971) }

  it 'sends a movie to the UpdateSingleMovieWorker' do
    expect(UpdateSingleMovieWorker).to receive(:perform_async).with(movie)

    subject.perform
  end
end
