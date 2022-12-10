# frozen_string_literal: true

class UrlShortner
  class << self
    def call(long_url:)
      url = Url.find_by(long_url:)
      return url if url.exists?

      create_url(long_url)
    end

    private

    def create_url(long_url); end
  end
end
