# frozen_string_literal: true

RSpec.describe Types::Money do
  let(:value) { '1234.09' }
  let(:precision) { 2 }

  describe '#new' do
    subject { described_class.new(value) }

    context 'when empty string' do
      let(:value) { '' }

      it { expect(subject.value).to eq(0) }
    end

    context 'when simple value' do
      let(:value) { '333.99' }

      it { expect(subject.value).to eq(333.99) }
    end

    context 'when nil value' do
      let(:value) { nil }

      it { expect(subject.value).to eq(0) }
    end
  end

  describe '#value' do
    subject { described_class.new(value, precision).value }

    context 'when value with only integer part' do
      let(:value) { '333' }

      it { expect(subject).to eq(333.00) }
    end

    context 'when value with only float part' do
      let(:value) { '0.55' }

      it { expect(subject).to eq(0.55) }
    end

    context 'when value with both parts' do
      let(:value) { '33.55' }

      it { expect(subject).to eq(33.55) }
    end

    context 'when float_part bigger then precision' do
      let(:value) { '33.5666' }

      it { expect(subject).to eq(33.57) }
    end

    context 'when precision is not default' do
      let(:value) { '33.56668' }
      let(:precision) { 4 }

      it { expect(subject).to eq(33.5667) }
    end
  end

  describe '#to_s' do
    subject { described_class.new(value, precision).to_s }

    context 'when value less than 1000' do
      let(:value) { '777.9' }

      it { expect(subject).to eq('777,90') }
    end

    context 'when value less than 10000' do
      let(:value) { '9483.8' }

      it { expect(subject).to eq('9 483,80') }
    end

    context 'when value greater than 100000' do
      let(:value) { '1239483.8' }

      it { expect(subject).to eq('1 239 483,80') }
    end

    context 'when precision greater then 1000 float part should not be divided' do
      let(:value) { '7777.123456' }
      let(:precision) { 5 }

      it { expect(subject).to eq('7 777,12346') }
    end
  end

  describe '#align_side' do
    subject { described_class.new(value).align_side }

    it { expect(subject).to eq(:right) }
  end
end
