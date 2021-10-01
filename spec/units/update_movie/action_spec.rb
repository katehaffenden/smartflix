# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateMovie::Action do
  subject { described_class.new }

  let!(:movie) { create(:movie, title: 'Jaws') }

  let(:fake_omdb_adapter) { instance_double(Omdb::ApiAdapter) }
  let(:response) { instance_double(HTTParty::Response, body: response_body) }
  let(:response_body) do
    { 'Title' => 'Jaws', 'Year' => '1975', 'Rated' => 'Passed', 'Runtime' => '300 min', 'Genre' => 'Comedy' }
  end

  before do
    allow(subject).to receive(:omdb_adapter).and_return(fake_omdb_adapter)
    allow(fake_omdb_adapter).to receive(:get_movie).and_return(response)
    allow(response).to receive(:parsed_response).and_return(response_body)
  end

  context 'when provided with new data in the response' do
    let(:response_body) do
      { 'Title' => 'Jaws', 'Genre' => 'Comedy', 'Year' => '1975' }
    end
    let(:movie) { create(:movie, title: 'Jaws', genre: 'Adventure', year: '1960') }

    it 'updates the movie object' do
      expect { subject.call(movie) }.to change(movie, :updated_at)
    end

    it 'updates movie with attributes from the response' do
      subject.call(movie)
      expect(movie.reload).to have_attributes(title: 'Jaws', year: 1975, genre: 'Comedy')
    end
  end

  context 'when provided with no new data in the response' do
    let(:response_body) do
      { 'Title' => 'Jaws', 'Genre' => 'Adventure' }
    end
    let(:movie) { create(:movie, title: 'Jaws', genre: 'Adventure') }

    it ' does not update the movie object' do
      expect { subject.call(movie) }.not_to change(movie, :updated_at)
    end

    it 'updates movie with attributes from the response' do
      subject.call(movie)
      expect(movie.reload).to have_attributes(title: 'Jaws', genre: 'Adventure')
    end
  end
end
