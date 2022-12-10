# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlShortener do
  describe '.call' do
    subject { described_class.call(long_url:) }

    context 'given long_url is not a valid url' do
      let(:long_url) { 'foo' }

      it 'returns false for success' do
        expect(subject[:success]).to eq(false)
      end

      it 'does not create a new url object' do
        expect { subject }.to_not change(Url, :count).from(0)
      end

      it 'returns an error message' do
        expect(subject[:errors]).to include('Long url is not a valid URL')
      end
    end

    context 'given long_url is a valid url' do
      let(:long_url) { 'https://example.com/' }

      context 'when the long_url has been shortened' do
        before do
          FactoryBot.create(:url, long_url:)
        end

        it 'returns true for successful' do
          expect(subject[:success]).to eq(true)
        end

        it 'does not create a new url object' do
          expect { subject }.to_not change(Url, :count).from(1)
        end

        it 'returns a url object with both a long_url and a short_url' do
          expect(subject[:url].long_url).to eq long_url
          expect(subject[:url].short_url.length).to eq 7
        end
      end

      context 'when the long_url has not already been shortened' do
        it 'returns true for successful' do
          expect(subject[:success]).to eq(true)
        end

        it 'does create a new url object' do
          expect { subject }.to change(Url, :count).from(0).to(1)
        end

        it 'returns a url object with both a long_url and a short_url' do
          expect(subject[:url].long_url).to eq long_url
          expect(subject[:url].short_url.length).to eq 7
        end
      end
    end
  end
end
