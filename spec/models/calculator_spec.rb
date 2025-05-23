require 'rails_helper'

RSpec.describe Calculator, type: :model do
  # Test 1
  it 'is defined' do
    expect(defined?(Calculator)).to eq('constant')
  end

  # Test 2
  it 'has method add with single argument' do
    expect(Calculator).to respond_to(:add).with(1).argument
  end

  # Test 3
  it 'accepts string as argument' do
    expect { Calculator.add('1,2') }.not_to raise_error
    expect { Calculator.add(1) }.to raise_error(ArgumentError)
    expect { Calculator.add(nil) }.to raise_error(ArgumentError)
    expect { Calculator.add([]) }.to raise_error(ArgumentError)
  end

  # Test 4
  it 'can take upto 2 numbers' do
    expect { Calculator.add('1,2') }.not_to raise_error
    expect { Calculator.add('1') }.not_to raise_error
    expect { Calculator.add('') }.not_to raise_error
    expect { Calculator.add('1,2,3') }.not_to raise_error
    expect { Calculator.add('1,2,3,4') }.not_to raise_error
    expect { Calculator.add('1,2,3,4,11,22,34') }.not_to raise_error
  end

  # Test 5
  it 'should return expected sum' do
    expect { Calculator.add('a,b') }.to raise_error(ArgumentError)
    expect { Calculator.add('a,1') }.to raise_error(ArgumentError)
    expect(Calculator.add('11,22')).to eq(33)
    expect(Calculator.add('10')).to eq(10)
    expect(Calculator.add('')).to eq(0)
    expect(Calculator.add('1,2,3,4,11,22,34')).to eq(77)
    expect(Calculator.add('1,2,3,4')).to eq(10)
  end

  # Test 6
  it 'should support \n as delimiter' do
    expect(Calculator.add("1\n2")).to eq(3)
    expect(Calculator.add("1,2\n3")).to eq(6)
    expect(Calculator.add("1,2\n3,4")).to eq(10)
    expect(Calculator.add("1,2\n3,4,5")).to eq(15)
  end

  # Test 7
  it 'should support custom delimiter' do
    expect(Calculator.add("//[;]\n1;2")).to eq(3)
    expect(Calculator.add("//[:]\n1:2:3")).to eq(6)
    expect(Calculator.add("//[;]\n1;2\n3;4")).to eq(10)
    expect(Calculator.add("//[;]\n1;2;3;4\n5")).to eq(15)
    expect(Calculator.add("//[;;;]\n1;;;2;;;3;;;4\n5")).to eq(15)
    expect(Calculator.add("//[***]\n1***2***3")).to eq(6)
    expect(Calculator.add("//[;][*]\n1;2;3*4\n5")).to eq(15)
    expect(Calculator.add("//[***][///]\n1***2///3")).to eq(6)
    expect(Calculator.add("//[***][///][;]\n1***2///3;4")).to eq(10)
  end

  # Test 8
  it 'should not support negative numbers' do
    expect { Calculator.add("-1,2") }.to raise_error(ArgumentError, 'negatives not allowed: -1')
    expect { Calculator.add("-1,2,-3,5") }.to raise_error(ArgumentError, 'negatives not allowed: -1, -3')
    expect { Calculator.add("//[;]\n1;2;-3;4\n-5") }.to raise_error(ArgumentError, 'negatives not allowed: -3, -5')
  end

  # Test 9
  it 'should ignore numbers greater than 1000' do
    expect(Calculator.add("1001,2")).to eq(2)
    expect(Calculator.add("1000,2")).to eq(1002)
    expect(Calculator.add("//[;]\n1001;2")).to eq(2)
    expect(Calculator.add("//[;]\n1000;2")).to eq(1002)
    expect(Calculator.add("//[***][///]\n1***2000///3")).to eq(4)
  end
end
