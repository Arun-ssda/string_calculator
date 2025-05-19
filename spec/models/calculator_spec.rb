require 'rails_helper'

RSpec.describe Calculator, type: :model do
  it 'is defined' do
    expect(defined?(Calculator)).to eq('constant')
  end
end
