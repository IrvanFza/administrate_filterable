require 'csv'

module AdministrateFilterable
  class FiltererService
    def self.filter_attributes(dashboard, resource)
      new(dashboard, resource).filter_attributes
    end

    def initialize(dashboard, resource)
      @dashboard = dashboard
      @resource = resource
    end

    def filter_attributes
      form = Administrate::Page::Form.new(@dashboard, @resource)

      attributes.map do |attribute|
        form.send :attribute_field, @dashboard, @resource, attribute, :form
      end
    end

    private

    def attributes
      return @dashboard.class::FILTER_ATTRIBUTES if @dashboard.class.const_defined?("FILTER_ATTRIBUTES")

      @dashboard.class::COLLECTION_ATTRIBUTES
    end
  end
end
