# frozen_string_literal: true

class Url < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true, url: true
  validates :short_url, presence: true, uniqueness: true
end
