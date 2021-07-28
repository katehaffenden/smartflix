# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DestroyMovie::EntryPoint do
  subject { described_class.new(movie) }

  let!(:movie) { create(:movie) }

  it 'deletes a record from the database' do
    expect { subject }.to change(Movie, :count).by(-1)
  end
end
