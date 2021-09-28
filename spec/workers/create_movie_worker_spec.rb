# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMovieWorker do
  subject { described_class.new }

  let(:title) { 'Some+Like+It+Hot' }
  let(:fake_omdb_adapter) { instance_double(Omdb::ApiAdapter) }
  let(:response) { instance_double(HTTParty::Response, body: response_body) }
  let(:response_body) do
    { 'Title' => 'Some Like It Hot', 'Year' => '1959', 'Rated' => 'Passed',
      'Released' => '19 Mar 1959', 'Runtime' => '121 min',
      'Plot' => 'Plot summary goes here', 'Genre' => 'Comedy' }
  end

  before do
    allow(subject).to receive(:omdb_adapter).and_return(fake_omdb_adapter)
    allow(fake_omdb_adapter).to receive(:fetch_data).and_return(response)
    allow(response).to receive(:parsed_response).and_return(response_body)
  end

  it 'calls CreateMovie::EntryPoint' do
    expect(CreateMovie::EntryPoint).to receive(:new).and_call_original

    subject.perform(title)
  end
end
