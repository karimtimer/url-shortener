# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlShortner do
  describe '.call' do
    subject { UrlShortner.call(long_url:) }

    context 'given long_url is not a valid url' do
      let(:long_url) { 'foo' }

      it 'returns false for successful'
      it 'does not create a new url object'
      it 'returns an error message'
    end

    context 'given long_url is a valid url' do
      let(:long_url) { 'https://example.com/' }

      context 'when the long_url has been shortened' do
        it 'returns true for successful'
        it 'does not create a new url object'
        it 'returns a url object with both a long_url and a short_url'
      end

      context 'when the long_url has not already been shortened' do
        it 'returns true for successful'
        it 'does create a new url object'
        it 'returns a url object with both a long_url and a short_url'
      end
    end
  end
end
