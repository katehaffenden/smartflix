# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMovieWorker do
  subject { described_class.new }

  let(:title) { 'Some+Like+It+Hot' }

  it 'calls CreateMovie::EntryPoint with a movie title' do
    expect_any_instance_of(CreateMovie::EntryPoint).to receive(:call).with(title)

    subject.perform(title)
  end
end
