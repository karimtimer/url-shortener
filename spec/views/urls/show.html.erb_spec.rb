# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'urls/show', type: :view do
  before(:each) do
    assign(:url, url)
  end
  let(:url) { FactoryBot.create(:url) }

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(%r{https://example.com/})
    expect(rendered).to match(/#{url.short_url}/)
  end
end
