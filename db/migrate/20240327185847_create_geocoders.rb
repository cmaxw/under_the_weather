class CreateGeocoders < ActiveRecord::Migration[7.1]
  def change
    create_table :geocoders do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.string :latitude
      t.string :longitude

      t.timestamps
    end

    add_index :geocoders, %i[address city state country postal_code], name: :geocoder_address
  end
end
