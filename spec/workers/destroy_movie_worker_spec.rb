# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DestroyMovieWorker do
  subject { described_class.new }

  before do
    freeze_time
  end

  context 'when a movie has not been updated in 48 hours' do
    before do
      create(:movie, title: 'Jaws', updated_at: 72.hours.ago)
    end

    it 'calls DestroyMovie::EntryPoint' do
      expect(DestroyMovie::EntryPoint).to receive(:new).and_call_original

      subject.perform
    end
  end

  context 'when a movie has been updated in the last 48 hours' do
    before do
      create(:movie, title: 'Toy Story', updated_at: 12.hours.ago)
    end

    it 'does not call the DestroyMovie::EntryPoint' do
      expect(DestroyMovie::EntryPoint).not_to receive(:new)

      subject.perform
    end
  end
end
