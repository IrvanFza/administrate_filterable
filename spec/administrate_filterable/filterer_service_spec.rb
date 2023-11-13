require 'rails_helper'

RSpec.describe AdministrateFilterable::FiltererService, type: :helper do
  describe '#filter_attributes' do
    let(:default_attributes) { AdministrateFilterable::FiltererService.filter_attributes(UserDashboard.new, User.new) }
    let(:defined_attributes) { AdministrateFilterable::FiltererService.filter_attributes(RoleDashboard.new, Role.new) }

    context 'filter attributes are not defined' do
      it 'generate correct default filter attributes' do
        filter_attributes = default_attributes.map { |r| r.attribute }
        # Default attributes are attributes that are defined in COLLECTION_ATTRIBUTES
        expect(filter_attributes.join(',')).to eq 'first_name,last_name,email,roles'
      end
    end

    context 'filter attributes are defined' do
      it 'generate correct defined filter attributes' do
        filter_attributes = defined_attributes.map { |r| r.attribute }
        expect(filter_attributes.join(',')).to eq 'name,user'
      end
    end
  end
end
