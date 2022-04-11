# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Newsletter, type: :model) do
  subject do
    described_class.new(title: 'Intro', message: 'Howdy we are ASLA')
  end

  it 'is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).not_to(be_valid)
  end

  it 'is not valid without an message' do
    subject.message = nil
    expect(subject).not_to(be_valid)
  end
end
