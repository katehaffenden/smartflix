# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMovieWorker do
  describe '#perform' do
    subject { described_class.new }

    let(:title) { 'Some+Like+It+Hot' }
    let(:fake_omdb_adapter) { instance_double(Omdb::ApiAdapter) }
    let(:response) do
      { 'Title' => 'Some Like It Hot', 'Year' => '1959', 'Rated' => 'Passed',
        'Released' => '19 Mar 1959', 'Runtime' => '121 min',
        'Plot' => 'Plot summary goes here', 'Genre' => 'Comedy' }
    end

    before do
      allow(subject).to receive(:omdb_adapter).and_return(fake_omdb_adapter)
      allow(fake_omdb_adapter).to receive(:fetch_data).and_return(response)
    end

    it 'saves a Movie object with correct attributes' do
      expect(subject.perform(title)).to have_attributes(title: 'Some Like It Hot', year: 1959, rated: 'Passed',
                                                        released: '1959-03-19 00:00:00.000000000 +0000'.to_datetime,
                                                        runtime: '121 min', plot: 'Plot summary goes here',
                                                        genre: 'Comedy')
    end
  end
end
