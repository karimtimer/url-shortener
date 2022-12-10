# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    long_url { 'https://example.com/' }
    short_url { 'shrt' }
  end
end
