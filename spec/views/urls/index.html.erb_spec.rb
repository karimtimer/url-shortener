# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'urls/index', type: :view do
  before(:each) do
    assign(:urls,
           [FactoryBot.create(:url, long_url: 'https://www.woo.com', short_url: 'woo'),
            FactoryBot.create(:url, long_url: 'https://www.yay.com', short_url: 'yay')])
  end

  it 'renders a list of urls' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('woo'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('yay'.to_s), count: 2
  end
end
