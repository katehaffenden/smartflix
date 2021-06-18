# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OmdbApiAdapter do
  context 'when no title parameter is supplied' do
    subject { OmdbApiAdapter.fetch_data }

    it 'makes a call to omdb api' do
      allow(OmdbApiAdapter).to receive(:get_movie_title).and_return('Some+Like+It+Hot')
      request = stub_request(:get, 'http://www.omdbapi.com/?apikey=9ae4798d&t=Some%20Like%20It%20Hot')
                .with(
                  headers: {
                    'Accept' => '*/*',
                    'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                    'User-Agent' => 'Ruby'
                  }
                )
                .to_return(status: 200, body: '"{Title => Some Like It Hot}"', headers: {})

      subject
      expect(request).to have_been_requested.once
    end
  end

  context 'when a title parameter is supplied' do
    subject { OmdbApiAdapter.fetch_data(title) }
    let(:title) { 'The Godfather' }

    it 'makes a request with the provided movie title' do
      request = stub_request(:get, 'http://www.omdbapi.com/?apikey=9ae4798d&t=The%20Godfather')
                .with(
                  headers: {
                    'Accept' => '*/*',
                    'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                    'User-Agent' => 'Ruby'
                  }
                )
                .to_return(status: 200, body: '"{Title => The Godfather}"', headers: {})

      subject
      expect(request).to have_been_requested.once
    end
  end
end
