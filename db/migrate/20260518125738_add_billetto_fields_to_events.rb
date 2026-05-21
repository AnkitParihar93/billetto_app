class AddBillettoFieldsToEvents < ActiveRecord::Migration[8.0]
   def change
    # meta
    add_column :events, :object_type, :string
    add_column :events, :kind, :string
    add_column :events, :state, :string
    add_column :events, :availability, :boolean

    # dates
    add_column :events, :startdate, :datetime
    add_column :events, :enddate, :datetime

    # urls
    add_column :events, :url, :text
    add_column :events, :branded_url, :text

    # price
    add_column :events, :price_cents, :integer
    add_column :events, :currency, :string

    # organiser
    add_column :events, :organiser_id, :integer
    add_column :events, :organiser_name, :string

    # location
    add_column :events, :location_name, :string
    add_column :events, :address_line, :string
    add_column :events, :city, :string
    add_column :events, :postal_code, :string
    add_column :events, :country, :string
    add_column :events, :region, :string
    add_column :events, :subregion, :string
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float

    # category
    add_column :events, :category, :string
    add_column :events, :category_localized, :string
    add_column :events, :subcategory, :string
    add_column :events, :subcategory_localized, :string
    add_column :events, :event_type, :string
    add_column :events, :event_type_localized, :string

    # organization
    add_column :events, :organization_id, :integer
    add_column :events, :organization_domain, :string

    # json backup
    add_column :events, :raw_data, :json
  end
end


