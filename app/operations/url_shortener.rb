# frozen_string_literal: true

class UrlShortener
  class << self
    def call(long_url:)
      url =  Url.find_by(long_url:)
      return { success: true, url: } unless url.nil?

      url ||= create_url(long_url)

      if url.persisted?
        { success: true, url: }
      else
        { success: false, errors: url.errors.full_messages }
      end
    end

    private

    def create_url(long_url)
      Url.create(long_url:, short_url: 'shrt')
    end
  end
end
