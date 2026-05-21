require "json"

file = File.read(Rails.root.join("db/events.json"))
events_json = JSON.parse(file)

events = events_json["data"]

events.each do |e|

  event = Event.find_or_initialize_by(external_id: e["id"])

  event.title = e["title"]
  event.description = e["description"]

  event.image_url =
    e.dig("image", "url") ||
    e["image_url"] ||
    e["image_link"]

  event.url = e["url"]
  event.branded_url = e["branded_url"]

  event.object_type = e["object"]
  event.kind = e["kind"]
  event.state = e["state"]
  event.availability = e["availability"]

  event.startdate = e["startdate"]
  event.enddate = e["enddate"]

  event.price_cents = e.dig("minimum_price", "amount_in_cents")
  event.currency = e.dig("minimum_price", "currency")

  event.organiser_id = e.dig("organiser", "id")
  event.organiser_name = e.dig("organiser", "name")

  event.location_name = e.dig("location", "location_name")
  event.address_line = e.dig("location", "address_line")
  event.city = e.dig("location", "city")
  event.postal_code = e.dig("location", "postal_code")
  event.country = e.dig("location", "country")
  event.region = e.dig("location", "region")
  event.subregion = e.dig("location", "subregion")

  event.latitude = e.dig("location", "coordinates", "latitude")
  event.longitude = e.dig("location", "coordinates", "longitude")

  # CATEGORIZATION
  event.category = e.dig("categorization", "category")
  event.category_localized = e.dig("categorization", "category_localized")

  event.subcategory = e.dig("categorization", "subcategory")
  event.subcategory_localized = e.dig("categorization", "subcategory_localized")

  event.event_type = e.dig("categorization", "type")
  event.event_type_localized = e.dig("categorization", "type_localized")

  event.organization_id = e.dig("organization", "id")
  event.organization_domain = e.dig("organization", "domain")

  event.raw_data = e

  event.save!

end

puts "Events seeded successfully 🚀"