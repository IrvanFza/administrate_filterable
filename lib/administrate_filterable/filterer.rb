module AdministrateFilterable
  module Filterer
    extend ActiveSupport::Concern

    included do
      filterable
    end

    class_methods do
      def filterable
        # TODO: Figure out a better way to implement the filter functionality
        # I don't think overriding `scoped_resource` is the ideal solution to implement the filter functionality.
        # Because when the Administrate controller is generated, it includes suggestion for overriding `scoped_resource`.
        # I already tried to override Administrate `filter_resources` method, but it doesn't work as expected.
        # So, let's stick with this solution for now. Suggestions are very welcomed!
        define_method(:scoped_resource) do
          resources = resource_class.default_scoped
          filtered_resources(resources)
        end
      end
    end

    def filtered_resources(resources)
      @is_filterable = true

      filter_params = params[resource_name]
      return resources if filter_params.blank?

      filter_params.each do |key, value|
        next unless resources.column_names.include?(key.to_s) && value.present?

        # TODO: Add support for relational filter (e.g. filter by `belongs_to` association, etc)
        sanitized_query = ActiveRecord::Base.send(:sanitize_sql_array, ["#{key} LIKE ?", "%#{value}%"])
        resources = resources.where(sanitized_query)
      end

      resources
    end
  end
end
