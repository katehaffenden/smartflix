# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMovie::Action do
  subject { described_class.new }

  let(:title) { 'Some+Like+It+Hot' }
  let(:fake_omdb_adapter) { instance_double(Omdb::ApiAdapter) }
  let(:response_body) do
    { title: 'Some Like It Hot', year: '1959', rated: 'Passed', released: '19 Mar 1959', runtime: '121 min',
      genre: 'Comedy, Music, Romance', plot: 'After two male musicians witness a mob hit, they flee the state in an all-female band disguised as women, but further complications set in.',
      language: 'English', :ratings=>[{:source=>"Internet Movie Database", :rating=>"8.2/10"}, {:source=>"Rotten Tomatoes", :rating=>"95%"}, {:source=>"Metacritic", :rating=>"98/100"}], response: 'True' }
  end

  before do
    allow(subject).to receive(:omdb_adapter).and_return(fake_omdb_adapter)
    allow(fake_omdb_adapter).to receive(:get_movie).and_return(response_body)
  end

  context 'when provided with a valid response' do
    it 'adds a movie to the database' do
      expect { subject.call(title) }.to change(Movie, :count).by(1)
    end

    it 'adds associated ratings to the database' do
      subject.call(title)

      expect(ExternalRating.count).to eq(3)
    end
  end

  context 'when provided with an invalid response' do
    let(:response_body) do
      { response: 'False' }
    end

    it 'does not create a movie object' do
      expect { subject.call(title) }.not_to change(Movie, :count)
    end

    it 'does not create associated rating objects' do
      subject.call(title)

      expect(ExternalRating.count).to eq(0)
    end

    it 'logs a timestamped warning' do
      travel_to Time.zone.local(2020)
      expect(Rails.logger).to receive(:warn).with('2020-01-01 00:00:00 UTC Request returned an error in the response')

      subject.call(title)
    end
  end
end
