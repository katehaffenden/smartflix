# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMovie::Action do
  subject { described_class.new.call(response) }

  let(:response) do
    instance_double(HTTParty::Response, body: response_body)
  end
  let(:response_body) do
    { 'Title' => 'Some Like It Hot', 'Year' => '1959', 'Rated' => 'Passed',
      'Released' => '19 Mar 1959', 'Runtime' => '121 min',
      'Plot' => 'Plot summary goes here', 'Genre' => 'Comedy' }
  end

  before do
    allow(response).to receive(:parsed_response).and_return(response_body)
  end

  context 'when provided with a valid response' do
    it 'adds a movie to the database' do
      expect { subject }.to change(Movie, :count).by(1)
    end

    it 'adds a movie with attributes from the response' do
      expect(subject).to have_attributes(title: 'Some Like It Hot', year: 1959, rated: 'Passed',
                                         released: '1959-03-19 00:00:00.000000000 +0000'.to_datetime,
                                         runtime: '121 min', plot: 'Plot summary goes here',
                                         genre: 'Comedy')
    end
  end

  context 'when provided with an invalid response' do
    let(:response_body) do
      '{"Response":"False","Error":"Movie not found!"}'
    end

    it 'does not create a movie object' do
      expect { subject }.not_to change(Movie, :count)
    end

    it 'logs a timestamped warning' do
      travel_to Time.zone.local(2020)
      expect(Rails.logger).to receive(:warn).with("2020-01-01 00:00:00 UTC Request returned an error in the response")

      subject
    end
  end
end
