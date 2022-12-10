class AddShortUrlIndexToUrl < ActiveRecord::Migration[7.0]
  def change
    add_index :urls, :short_url, unique: true
  end
end
