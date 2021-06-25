# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OmdbApiAdapter do

  describe '#fetch_data' do
    context 'when no title parameter is supplied' do
      subject { described_class.fetch_data }

      it 'makes a call to the omdb api, returning a hash of movie data' do
        allow(OmdbApiAdapter).to receive(:get_movie_title).and_return('Some+Like+It+Hot')

        VCR.use_cassette "movie_request_some_like_it_hot" do

          expect(subject).to be_a_kind_of Hash
          expect(subject['Title']).to eq("Some Like It Hot")
        end
      end
    end

    context 'when a title parameter is supplied' do
      subject { described_class.fetch_data(title) }
      let(:title) { 'The Godfather' }

      it 'makes a request with the provided movie title' do
        VCR.use_cassette "movie_request_the_godfather" do

          expect(subject).to be_a_kind_of Hash
          expect(subject['Title']).to eq("The Godfather")
        end
      end
    end
  end
end
