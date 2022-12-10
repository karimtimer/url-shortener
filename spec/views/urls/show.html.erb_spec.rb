# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'urls/show', type: :view do
  before(:each) do
    assign(:url, FactoryBot.create(:url))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(%r{https://example.com/})
    expect(rendered).to match(/shrt/)
  end
end
