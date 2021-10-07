# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateSingleMovieWorker do
  subject { described_class.new }

  let!(:movie) { create(:movie, title: 'The Godfather', year: 1971) }

  it 'calls the UpdateMovie::EntryPoint with a movie' do
    expect_any_instance_of(UpdateMovie::EntryPoint).to receive(:call).with(movie)

    subject.perform(movie)
  end
end

