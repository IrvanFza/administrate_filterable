require "administrate_filterable/version"
require "administrate_filterable/filterer_service"
require "administrate_filterable/filterer"
require "administrate/engine"

module AdministrateFilterable
  class Engine < ::Rails::Engine
    Administrate::Engine.add_javascript "administrate_filterable/application"
    Administrate::Engine.add_stylesheet "administrate_filterable/application"
  end
end
