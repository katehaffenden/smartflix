# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DestroyMovieWorker do
  subject { described_class.new }

  before do
    travel_to Time.zone.local(2021)
  end

  after do
    travel_back
  end

  context 'when a movie has not been updated in 48 hours' do
    let!(:movie_updated) { create(:movie, updated_at: 72.hours.ago) }

      it 'calls DestroyMovie::EntryPoint' do
        expect(DestroyMovie::EntryPoint).to receive(:new)

        subject.perform
      end

      it 'does delete a movie from the database' do
        expect { subject.perform }.to change(Movie, :count).by(-1)
      end
  end

  context 'when a movie has been updated in the last 48 hours' do
    let!(:movie_not_updated) { create(:movie, updated_at: 12.hours.ago) }

    it 'does not call the DestroyMovie::EntryPoint' do
      expect(DestroyMovie::EntryPoint).to_not receive(:new)

      subject.perform
    end
  end


end
