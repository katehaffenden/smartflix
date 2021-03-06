require 'rails_helper'

RSpec.describe Omdb::ApiAdapter do
  describe '#get_movie' do
    context 'when no title parameter is supplied' do
      subject { described_class.new }

      it 'makes a request returning an HTTP response' do
        allow(described_class.new).to receive(:movie_title).and_return('Some+Like+It+Hot')

        VCR.use_cassette 'movie_request_some_like_it_hot' do
          response = subject.get_movie
          expect(response[:title]).to eq('Some Like It Hot')
        end
      end
    end

    context 'when title is supplied' do
      let(:title) { 'The Godfather' }

      it 'makes a request returning an HTTP response' do
        VCR.use_cassette 'movie_request_the_godfather' do
          response = subject.get_movie(title)
          expect(response[:title]).to eq('The Godfather')
        end
      end
    end
  end

  describe '#movie_title' do
    subject { described_class.new.movie_title }

    it 'generates a movie title' do
      allow(Faker::Movie).to receive(:title).and_return('The Big Lebowski')

      expect(subject).to eq('The+Big+Lebowski')
    end
  end
end
