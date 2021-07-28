# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DestroyMovie::Action do
  subject { described_class.new.call(movie) }

  let!(:movie) { create(:movie) }

  it 'deletes a movie to the database' do
    expect { subject }.to change(Movie, :count).by(-1)
  end
end
