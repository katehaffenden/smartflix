# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateMovieWorker do
  subject { described_class.new }

  let!(:movie) { create(:movie, title: 'Jaws') }
  let(:fake_omdb_adapter) { instance_double(Omdb::ApiAdapter) }
  let(:response) { instance_double(HTTParty::Response, body: response_body) }
  let(:response_body) do
    { 'Title' => 'Jaws', 'Year' => '1975', 'Rated' => 'Passed', 'Runtime' => '300 min', 'Genre' => 'Comedy' }
  end

  before do
    allow(subject).to receive(:omdb_adapter).and_return(fake_omdb_adapter)
    allow(fake_omdb_adapter).to receive(:fetch_data).and_return(response)
    allow(response).to receive(:parsed_response).and_return(response_body)
  end

  it 'updates the movie record' do
    subject.perform
    expect(movie.reload).to have_attributes(runtime: '300 min', year: 1975, rated: 'Passed', genre: 'Comedy')
  end

  it 'calls the UpdateMovie::EntryPoint' do
    expect(UpdateMovie::EntryPoint).to receive(:new).and_call_original

    subject.perform
  end
end
