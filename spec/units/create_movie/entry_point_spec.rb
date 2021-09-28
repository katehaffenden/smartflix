# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMovie::EntryPoint do
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

  it 'adds a movie record to the database' do
    expect { subject }.to change(Movie, :count).by(1)
  end
end
