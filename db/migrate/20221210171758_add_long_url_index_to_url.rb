class AddLongUrlIndexToUrl < ActiveRecord::Migration[7.0]
  def change
    add_index :urls, :long_url, unique: true
  end
end
