# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'urls/edit', type: :view do
  let(:url) { FactoryBot.create(:url) }

  before(:each) do
    assign(:url, url)
  end

  it 'renders the edit url form' do
    render

    assert_select 'form[action=?][method=?]', url_path(url), 'post' do
      assert_select 'input[name=?]', 'url[long_url]'
    end
  end
end
