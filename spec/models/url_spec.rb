# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe '#long_url' do
    subject { Url.create(long_url:, short_url: 'short') }

    context 'given a valid url' do
      let(:long_url) { 'https://www.longurl.com' }

      it { is_expected.to be_valid }
    end

    context 'given an invalid url' do
      let(:long_url) { 'longurl' }

      it { is_expected.to_not be_valid }
    end
  end
end
