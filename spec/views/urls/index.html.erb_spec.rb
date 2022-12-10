# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'urls/index', type: :view do
  before(:each) do
    assign(:urls, [
             Url.create!(
               long_url: 'Long Url',
               short_url: 'Short Url'
             ),
             Url.create!(
               long_url: 'Long Url',
               short_url: 'Short Url'
             )
           ])
  end

  it 'renders a list of urls' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Long Url'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Short Url'.to_s), count: 2
  end
end
