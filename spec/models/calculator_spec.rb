require 'rails_helper'

RSpec.describe Calculator, type: :model do
  it 'is defined' do
    expect(defined?(Calculator)).to eq('constant')
  end

  it 'has method add with single argument' do
    expect(Calculator).to respond_to(:add).with(1).argument
  end

  it 'accepts string as argument' do
    expect { Calculator.add('1,2') }.not_to raise_error
    expect { Calculator.add(1) }.to raise_error(ArgumentError)
    expect { Calculator.add(nil) }.to raise_error(ArgumentError)
    expect { Calculator.add([]) }.to raise_error(ArgumentError)
  end
end
