# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  # Define your fields
  field :host, type: :string, default: "http://localhost:3000"
  field :frontend, type: :string, default: "http://localhost:8080"
  field :account_creation_enabled?, type: :boolean, default: false
  field :site_name, type: :string, default: "Warehouse"
  field :map_name, type: :string, default: "blank"
end
