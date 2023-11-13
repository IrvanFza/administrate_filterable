module AdministrateFilterable
  module Filterer
    extend ActiveSupport::Concern

    included do
      filterable
    end

    class_methods do
      def filterable
        # TODO: Figure out a better way to implement the filter functionality
        # This is a hack to implement the filter functionality by overriding the scoped_resource method
        # It would be better to implement this as a separate controller action, but I don't have time to explore that right now
        define_method(:scoped_resource) do
          # TODO: Figure out a better way to pass the filter data to the form
          # This is a hack to get the filter resource and attributes to show up in the form, but it's not ideal
          # So I tried to make the variable name as unique as possible to avoid collisions
          @administrate_filterable_resource = resource_name.to_s.titleize.constantize.new
          @administrate_filterable_attributes = FiltererService.filter_attributes(dashboard, @administrate_filterable_resource)

          data = resource_class.all

          filter_params = params[resource_name]
          return data if filter_params.blank?

          filter_params.each do |key, value|
            next unless data.column_names.include?(key.to_s) && value.present?

            # TODO: Add support for relational filter (e.g. filter by `belongs_to` association, etc)
            sanitized_query = ActiveRecord::Base.send(:sanitize_sql_array, ["#{key} LIKE ?", "%#{value}%"])
            data = data.where(sanitized_query)
          end

          data
        end
      end
    end
  end
end
