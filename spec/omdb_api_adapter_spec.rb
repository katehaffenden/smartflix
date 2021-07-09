require 'rails_helper'

RSpec.describe Omdb::ApiAdapter do
  describe '#fetch_data' do
    context 'when no title parameter is supplied' do
      subject { described_class.new.fetch_data }
      let(:omdb_adapter) { Omdb::ApiAdapter.new }

      it 'makes a request to the omdb api, returning a hash of movie data' do
        allow(omdb_adapter).to receive(:get_movie_title).and_return('Some+Like+It+Hot')

        VCR.use_cassette 'movie_request_some_like_it_hot' do
          expect(subject).to be_a_kind_of Hash
          expect(subject['Title']).to eq('Some Like It Hot')
        end
      end
    end

    context 'when a title parameter is supplied' do
      subject { described_class.new.fetch_data(title) }

      context 'when title supplied is not valid' do
        let(:title) { 'Fake Movie Title' }
        it 'makes a request to the omdb api and logs the failed response' do

          VCR.use_cassette 'movie_request_invalid_title' do
            expect(Rails.logger).to receive(:warn).with("#{title} returned an error in the response")
            subject
          end
        end
      end

      context 'when title supplied is valid' do
        let(:title) { 'The Godfather' }
        it 'makes a request to the omdb api, returning a hash for the provided title' do
          VCR.use_cassette 'movie_request_the_godfather' do
            expect(subject).to be_a_kind_of Hash
            expect(subject['Title']).to eq('The Godfather')
          end
        end
      end
    end
  end

  describe '#get_movie_title' do
    subject { described_class.new.get_movie_title }
    it 'generates and formats a movie title' do
      allow(Faker::Movie).to receive(:title).and_return('The Big Lebowski')

      expect(subject).to eq('The+Big+Lebowski')
    end
  end
end
