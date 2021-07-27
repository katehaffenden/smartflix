# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateMovie::Action do
  subject { described_class.new.call(response, movie) }

  let(:response) do
    instance_double(HTTParty::Response, body: response_body)
  end

  before do
    allow(response).to receive(:parsed_response).and_return(response_body)
  end

  context 'when provided with new data in the response' do
    let(:response_body) do
      { 'Title' => 'Jaws', 'Genre' => 'Comedy', 'Year' => '1975' }
    end
    let(:movie) { create(:movie, title: 'Jaws', genre: 'Adventure', year: '1960') }

    it 'updates the movie object' do
      expect { subject }.to change(movie, :updated_at)
    end

    it 'updates movie with attributes from the response' do
      subject
      expect(movie.reload).to have_attributes(title: 'Jaws', year: 1975, genre: 'Comedy')
    end
  end

  context 'when provided with no new data in the response' do
    let(:response_body) do
      { 'Title' => 'Jaws', 'Genre' => 'Adventure' }
    end
    let(:movie) { create(:movie, title: 'Jaws', genre: 'Adventure') }

    it ' does not update the movie object' do
      expect { subject }.not_to change(movie, :updated_at)
    end

    it 'updates movie with attributes from the response' do
      subject
      expect(movie.reload).to have_attributes(title: 'Jaws', genre: 'Adventure')
    end
  end
end
